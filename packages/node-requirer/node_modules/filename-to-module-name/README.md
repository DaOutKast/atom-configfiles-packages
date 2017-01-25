[![npm](https://nodei.co/npm/filename-to-module-name.png)](https://nodei.co/npm/filename-to-module-name/)

# filename-to-module-name

[![Build Status][travis-badge]][travis] [![Dependency Status][david-badge]][david]

Returns the shortest module name for the given filename.

Here is a pseudocode, effectively the inverse of [require.resolve algorithm](https://nodejs.org/docs/latest/api/modules.html#modules_all_together) used by Node:
```
1. If X is a directory,
   a. return basename(X)
   b. STOP
2. Let Y be X with ".js", ".json" or ".node" removed
3. If exists(Y), return basename(X). STOP
4. For E in [".js", ".json", ".node"],
   a. If X ends with E, return basename(Y). STOP
   b. If exists(Y + E), return basename(X). STOP
5. Return basename(X)
```

[travis]: https://travis-ci.org/eush77/filename-to-module-name
[travis-badge]: https://travis-ci.org/eush77/filename-to-module-name.svg
[david]: https://david-dm.org/eush77/filename-to-module-name
[david-badge]: https://david-dm.org/eush77/filename-to-module-name.png

## Example

```js
var moduleName = require('filename-to-module-name');

moduleName('./index.js');
//=> "index"
```

## API

### `filenameToModuleName(filename)`

Returns the module name. `filename` should be a name of an existing file or directory.

## Install

```
npm install filename-to-module-name
```

## License

MIT
