var gulp   = require("gulp"),
    gulpif = require("gulp-if"),
    sass   = require("gulp-sass"),
    minifyCss = require("gulp-minify-css"),
    replace = require("gulp-replace"),
    babel = require('gulp-babel'),
    concat = require("gulp-concat"),
    uglify = require("gulp-uglify"),
    yaml   = require("js-yaml"),
    connect = require("gulp-connect"),

    exec = require('child_process').exec,

    fs   = require('fs'),
    path = require("path");

CONFIG = yaml.safeLoad(fs.readFileSync("nanoc.yaml", "utf8"));
IS_PRODUCTION = process.env.NODE_ENV == "production";


gulp.task("css", function() {
  return gulp.src("assets/stylesheets/*.css")
    .pipe(gulp.dest("output/assets/stylesheets/"));
});

gulp.task("sass", function() {
  return gulp.src("assets/stylesheets/*.scss")
    .pipe(sass())
    .pipe(gulpif(IS_PRODUCTION, minifyCss()))
    .pipe(gulp.dest("output/assets/stylesheets/"));
});

gulp.task("javascript_vendor", function () {
  return gulp.src([
    "assets/vendor/jquery/dist/jquery.js",
    "assets/vendor/mustache/mustache.js",
    "assets/vendor/lunr.js/lunr.js"
    ])
    .pipe(concat("vendor.js"))
    .pipe(gulp.dest("tmp/"));

})

gulp.task("javascript_babel", function () {
  return gulp.src([
    "assets/javascripts/*.js",
    ])
    .pipe(babel({
      presets: ['es2015']
    }))
    .pipe(concat("babel.js"))
    .pipe(gulp.dest("tmp/"));
});

gulp.task("javascript_workers", function () {
  return gulp.src([
    "assets/javascripts/workers/*.js",
    "assets/vendor/lunr.js/lunr.min.js"
    ])
    .pipe(gulp.dest("output/assets/javascripts/"));
});

gulp.task('javascript', ['javascript_vendor', 'javascript_babel', 'javascript_workers'], function () {
  return gulp.src(['./tmp/vendor.js', './tmp/babel.js'])
    .pipe(concat('application.js'))
    .pipe(gulpif(IS_PRODUCTION, uglify()))
    .pipe(gulp.dest('output/assets/javascripts/'))
})


gulp.task("octicons", function() {
  return gulp.src("assets/vendor/octicons/octicons/**/*")
    .pipe(gulp.dest("output/assets/vendor/octicons/octicons"));
});

gulp.task("images", function() {
  return gulp.src("assets/images/**/*")
    .pipe(gulp.dest("output/assets/images"));
});

gulp.task("favicon", function() {
  return gulp.src("assets/images/favicon.ico")
    .pipe(gulp.dest("output/"));
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
    "data/**/*",
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
gulp.task("assets", [ "css", "sass", 'javascript', "octicons", "images", "favicon" ]);
gulp.task("build", [ "nanoc:compile", "assets" ]);
gulp.task("default", [ "nanoc:compile", "assets", "serve" ]);
