---
title: How Atom Uses Chromium Snapshots
---
### How Atom Uses Chromium Snapshots

In order to improve startup time, when Atom is built we create a [V8 snapshot](https://v8project.blogspot.it/2015/09/custom-startup-snapshots.html) in which we preload core services and packages. Then, at runtime, we finish loading Atom by supplying all the information we didn't have during the compilation phase (e.g. loading third party packages, custom style sheets, configuration, etc.).

[electron-link](https://github.com/atom/electron-link) is the tool that powers snapshots, as it enables us to traverse the entire require graph (starting at the entry point) and replace all the [forbidden `require` calls](https://github.com/atom/atom/blob/74ff9fdb91205b89673209caf1e2ceb373e9c59f/script/lib/generate-startup-snapshot.js#L19-L65) (e.g. require calls to native modules, node core modules or other modules that can't be accessed in the snapshot [V8 context](https://github.com/v8/v8/wiki/Embedder%27s-Guide#contexts)) with a function that will be called at runtime. The output is a single script containing the code for all the modules reachable from the entry point, which we then [supply to mksnapshot](https://github.com/atom/atom/blob/74ff9fdb91205b89673209caf1e2ceb373e9c59f/script/lib/generate-startup-snapshot.js#L73-L78) to generate a snapshot blob.

The generated blob is finally [copied into the application bundle](https://github.com/atom/atom/blob/74ff9fdb91205b89673209caf1e2ceb373e9c59f/script/lib/generate-startup-snapshot.js#L80-L89) and will be automatically loaded by Electron when running Atom.
