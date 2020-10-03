var gulp   = require("gulp"),
    gulpif = require("gulp-if"),
    sass   = require("gulp-sass"),
    minifyCss = require("gulp-minify-css"),
    replace = require("gulp-replace"),
    babel = require("gulp-babel"),
    concat = require("gulp-concat"),
    uglify = require("gulp-uglify"),
    yaml   = require("js-yaml"),
    connect = require("gulp-connect"),
    fs   = require("fs"),
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
      presets: ["es2015"]
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

gulp.task("javascript_concat", function () {
  return gulp.src(["./tmp/vendor.js", "./tmp/babel.js"])
    .pipe(concat("application.js"))
    .pipe(gulpif(IS_PRODUCTION, uglify()))
    .pipe(gulp.dest("output/assets/javascripts/"))
});

gulp.task("javascript", gulp.series("javascript_vendor", "javascript_babel", "javascript_workers", "javascript_concat"));

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

gulp.task("extract_api_docs_data", function (cb) {
  const destDir = 'content/api';
  if (!fs.existsSync(destDir)) fs.mkdirSync(destDir);

  const srcDir = 'data/apis-by-version';
  fs.readdirSync(srcDir).forEach((file) => {
    if (path.extname(file) != '.json') return;
    const version = path.basename(file, '.json');
    const versionDestDir = `${destDir}/${version}`;
    if (!fs.existsSync(versionDestDir)) fs.mkdirSync(versionDestDir);

    const srcPath = `${srcDir}/${file}`;
    const docs = JSON.parse(fs.readFileSync(srcPath));
    for (klass in docs['classes']) {
      const destPath = `${versionDestDir}/${klass}.json`;
      const docsForClass = JSON.stringify(docs['classes'][klass]);
      fs.writeFileSync(destPath, docsForClass);
    }
  })

  cb();
});

gulp.task("nanoc:compile", function (cb) {
  const { spawn } = require('child_process');
  const compile = spawn('bundle', ['exec', 'nanoc', 'compile'], { stdio: 'inherit' });
  compile.on('close', (code) => {
    console.log(`'bundle exec nanoc compile' exited with code ${code}`);
    cb();
  })
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
  ], gulp.series("nanoc:compile"));
});

gulp.task("watch:assets", function() {
  gulp.watch([
    "assets/**/*"
  ], gulp.series("assets"));
});

gulp.task("serve", gulp.parallel("server", "watch:nanoc", "watch:assets"));
gulp.task("assets", gulp.parallel("css", "sass", "javascript", "octicons", "images", "favicon"));
gulp.task("build", gulp.parallel("extract_api_docs_data", "nanoc:compile", "assets"));
gulp.task("default", gulp.series("build", "serve"));
