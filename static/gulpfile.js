var gulp = require('gulp');
    imagemin = require('gulp-imagemin');

gulp.task('default', function() {
  gulp.src('images/*.jpg')
      .pipe(imagemin())
      .pipe(gulp.dest('images'))
});
