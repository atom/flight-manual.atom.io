---
title: Creating a Fork of a Core Package in atom/atom
---
### Creating a Fork of a Core Package in atom/atom

Several of Atom's core packages are maintained in the [`packages` directory of the atom/atom repository](https://github.com/atom/atom/tree/master/packages). If you would like to use one of these packages as a starting point for your own package, please follow the steps below.

{{#tip}}

**Tip:** In most cases, we recommend [generating a brand new package](../package-word-count/#package-generator) or a [brand new theme](../creating-a-theme/#creating-a-syntax-theme) as the starting point for your creation. The guide below applies only to situations where you want to create a package that closely resembles a core Atom package.

{{/tip}}

#### Creating Your New Package

For the sake of this guide, let's assume that you want to start with the current code in the [one-light-ui](https://github.com/atom/atom/tree/master/packages/one-light-ui) package, make some customizations to it, and publish your new package under the name "one-light-ui-plus".

1. Download the [current contents of the atom/atom repository as a zip file](https://github.com/atom/atom/archive/master.zip)

2. Unzip the file to a temporary location (for example <span class='platform-mac platform-linux'>`/tmp/atom`</span><span class='platform-windows'>`C:\TEMP\atom`</span>)

3. Copy the contents of the desired package into a working directory for your fork

    ``` command-line
    $ <span class='platform-mac platform-linux'>cp -R /tmp/atom/packages/one-light-ui ~/src/one-light-ui-plus</span><span class='platform-windows'>xcopy C:\TEMP\atom\packages\one-light-ui C:\src\one-light-ui-plus /E /H /K</span>
    ```

4. Create a local repository and commit the initial contents

    ``` command-line
    $ cd ~/src/one-light-ui-plus
    $ git init
    $ git commit -am "Import core Atom package"
    ```

5. Update the `name` property in `package.json` to give your package a unique name

6. Make the other customizations that you have in mind

7. Commit your changes

    ``` command-line
    $ git commit -am "Apply initial customizations"
    ```

8. [Create a public repository on github.com](https://help.github.com/articles/create-a-repo/) for your new package

9. Follow the instructions in the github.com UI to push your code to your new online repository

10. Follow the steps in the [Publishing guide](../publishing/) to publish your new package

#### Merging Upstream Changes into Your Package

The code in the original package will continue to evolve over time, either to fix bugs or to add new enhancements. You may want to incorporate some or all of those updates into your package. To do so, you can follow [these steps](../maintaining-a-fork-of-a-core-package-in-atom-atom/#step-by-step-guide) for merging upstream changes into your package.
