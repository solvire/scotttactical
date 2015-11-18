'use strict';
var gulp = require('gulp')
var less = require('gulp-less')
var path = require('path');
var mini = require('gulp-minify-css');
var miniH = require('gulp-minify-html');

gulp.task('less', function() {
	return gulp
		.src('./less/main.less')
		.pipe(less())
		.pipe(mini())
		.pipe(gulp.dest('./static/css'));
});


gulp.task('minify-html', function() {
	var opts = {
		conditionals : false,
		spare : true
	};

	return gulp.src('./public/**/*.html')
		.pipe(miniH(opts))
		.pipe(gulp.dest('./public/'));
});

gulp.task('default', [ 'less', 'minify-html' ])
