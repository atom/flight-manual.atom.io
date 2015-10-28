var gulp   = require("gulp"),
    gulpif = require("gulp-if"),
    sass   = require("gulp-sass"),
    minifyCss = require("gulp-minify-css"),
    replace = require("gulp-replace"),
    coffee = require("gulp-coffee"),
    concat = require("gulp-concat"),
    uglify = require("gulp-uglify"),
    yaml   = require("js-yaml"),
    connect = require("gulp-connect"),

    exec = require('child_process').exec,

    fs   = require('fs'),
    path = require("path");

CONFIG = yaml.safeLoad(fs.readFileSync("nanoc.yaml", "utf8"));
IS_PRODUCTION = process.env.NODE_ENV == "production";

var transformCS = function (file) {
  return path.extname(file.path) == ".coffee";
};

gulp.task("sass", function() {
  return gulp.src("assets/stylesheets/*.scss")
    .pipe(sass())
    .pipe(gulpif(IS_PRODUCTION, minifyCss()))
    .pipe(gulp.dest("output/assets/stylesheets/"));
});

gulp.task("javascript", function () {
  return gulp.src([
    "assets/javascripts/initial.js",
    "assets/vendor/jquery/dist/jquery.js",
    "assets/vendor/jquery-ui/jquery-ui.js",
    "assets/vendor/mustache/mustache.js",
    "assets/coffeescripts/**/*.coffee"
    ])
    .pipe(gulpif(transformCS, coffee()))
    .pipe(concat("application.js"))
    .pipe(replace(/\{\{ site\.version \}\}/g, CONFIG.latest_enterprise_version_float))
    .pipe(replace(/\{\{ site\.versions \}\}/g, CONFIG.versions))
    .pipe(gulpif(IS_PRODUCTION, uglify()))
    .pipe(gulp.dest("output/assets/javascript"));
});

gulp.task("javascript_workers", function () {
  return gulp.src([
    "assets/javascripts/search_worker.js",
    "assets/vendor/lunr.js/lunr.min.js"
    ])
    .pipe(gulp.dest("output/assets/javascript"));
});

gulp.task("octicons", function() {
  return gulp.src("assets/vendor/octicons/octicons/**/*")
    .pipe(gulp.dest("output/assets/vendor/octicons/octicons"));
});

gulp.task("images", function() {
  return gulp.src("assets/images/**/*")
    .pipe(gulp.dest("output/assets/images"));
});

gulp.task("nanoc:compile", function (cb) {
  exec("bundle exec nanoc compile", function (err, stdout, stderr) {
    console.log(stdout);
    console.log(stderr);
    cb(err);
  });
});

gulp.task("server", function() {
  connect.server({
    port: 4000,
    root: ["output"],
    fallback: "output/404.html"
  });
});

gulp.task("watch:nanoc", function() {
  gulp.watch([
    "nanoc.yaml",
    "Rules",
    "content/**/*",
    "layouts/**/*",
    "lib/**/*"
  ], ["nanoc:compile"]);
});

gulp.task("watch:assets", function() {
  gulp.watch([
    "assets/**/*"
  ], ["assets"]);
});

gulp.task("serve", [ "server", "watch:nanoc", "watch:assets" ]);
gulp.task("assets", [ "sass", "javascript", "javascript_workers", "octicons", "images" ]);
gulp.task("default", [ "nanoc:compile", "assets", "serve" ]);
