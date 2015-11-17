'use strict';
var gulp = require('gulp')
var less = require('gulp-less')
var path = require('path');
var mini = require('gulp-minify-css');

gulp.task('less', function() {
	return gulp
		.src('./less/main.less')
		.pipe(less())
		.pipe(mini())
		.pipe(gulp.dest('./static/css'));
});

gulp.task('default', [ 'less' ])
