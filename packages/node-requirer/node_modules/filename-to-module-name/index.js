'use strict';

var fs = require('fs'),
    basename = require('path').basename;


module.exports = function (filename) {
  var stat = fs.statSync(filename);
  if (stat.isDirectory()) {
    return basename(filename);
  }
  if (!stat.isFile) {
    throw new Error('File "' + filename + '" is neither a directory nor a file.');
  }

  var shortname = filename.match(/^(.*?)(\.(?:js|json|node))?$/)[1];
  if (exists(shortname)) {
    return basename(filename);
  }

  return ['.js', '.json', '.node'].reduce(function (result, ext) {
    if (result) return result;

    var f = shortname + ext;
    if (filename == f) {
      return basename(shortname);
    }
    if (exists(f)) {
      return basename(filename);
    }
  }, undefined) || basename(filename);
};


function exists(filename) {
  try {
    fs.statSync(filename);
    return true;
  }
  catch (e) {
    return false;
  }
}
