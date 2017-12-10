---
title: Cross-Platform Compatibility
---
### Cross-Platform Compatibility

Atom runs on a number of platforms and while Electron and Node take care of many of the details there are still some considerations to ensure your package works on other operating systems.

#### Symlinks

File symlinks can be used on Windows by non-Administrators by specifying 'junction' as the type (this argument is ignored on macOS & Linux).

Also consider:

* *Symlinks committed to Git* will not checkout correctly on Windows - _dynamically create what you need with `fs.symlink` instead_
* *Symlinked directories* are only available to Administrators on Windows - _avoid a dependency on them_

#### Filenames

* *Reserved filenames* on Windows are `com1`-`com9`, `lpt1`-`lpt9`, `con`, `nul`, `aux` and `prn` (regardless of extension, e.g. `prn.txt` is disallowed)
* *Reserved characters* on Windows are ? \ / < > ? % | : "  _so avoid where possible_
* *Names with spaces* when passed to the command line;
    * Windows requires you _surround the path with double quotes_ e.g. `"c:\my test"`
    * macOS and Linux require _a backslash before each space_ e.g. `/my\ test`

#### File paths

* Windows uses `\` although some tools and PowerShell allow `/` too
* macOS and Linux use `/`

You can dynamically find out what your platform uses with `path.sep` or better yet _use the node path library functions_ such as `join` and `normalize` which automatically take care of this.

Windows supports up to *250 characters* for a path - _avoid deeply nested directory structures_

#### Paths are not URLs

URL parsing routines should not be used on file paths. While they initially look like a relative path it will fail in a number of scenarios on all platforms.

* Various characters are misinterpreted, e.g. `?` as query string, `#` as a fragment identifier
* **Windows** drive specifiers are incorrectly parsed as a protocol

If you need to use a path for a URL use the file: protocol with an absolute path instead to ensure drive letters and slashes are appropriately addressed, e.g. `file:///c|/test/pic.png`

#### `fs.stat` on directories

The `fs.stat` function does not return the size of the contents of a directory but rather the allocation size of the directory itself. This returns 0 on Windows and 1024 on macOS and so should not be relied upon.

#### `path.relative` can't traverse drives

* On a macOS or Linux system `path.relative` can be used to calculate a relative path to traverse between any two given paths.
* On Windows this is not always possible as it can contain multiple absolute roots, e.g. `c:\` and `d:\`

#### Rapid file operations

Creation and deletion operations may take a few milliseconds to complete. If you need to remove many files and folders consider [RimRAF](https://www.npmjs.com/package/rimraf) which has built-in retry logic for this.

#### Line endings

* Windows uses `CRLF`
* macOS and Linux use `LF`
* Git on Windows often has `autocrlf` set which automatically converts between the two

If you are writing specs that use text file fixtures consider that this will interfere with file lengths, hash codes and direct text comparisons. It will also change the Atom selection length by 1 character per line.

If you have spec fixtures that are text files you may want to tell Git to force LF, CRLF or not convert them by specifying the paths in `.gitattributes` e.g.

```
spec/fixtures/always-crlf.txt eol=crlf
spec/fixtures/always-lf.txt eol=lf
spec/fixtures/leave-as-is.txt -text
```
