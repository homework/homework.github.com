[Homework](http://www.homenetworks.ac.uk/)
==========

This is the gravestone website for the Homework project, EP/F064276/1. The project was supported by EPSRC and involved the University of Nottingham, University of Glasgow, Imperial College, BT Research and Microsoft Research Cambridge. This site is hosted at <http://homework.github.com/>.

If you have permission to do so, basic instructions for editing the site are:

+ clone the repo at `git@github.com:homework/homework.github.com.git`

+ edit the `.md` (markdown) files, adding directories and files as you see fit
  (I tend to avoid `.html` extensions so use directories with `index.md` files
  in). 

+ `make test` runs a local copy via `jekyll` for testing on `localhost:4000`

+ `make deploy` runs `git status && git push` to check what the status of your edits is, and to push the current repository upstream to `github`.

### Prerequisites

`jekyll` (a ruby thing) and `lessc` (a node.js thing). The former builds the site and the latter rebuilds the css file -- you won't need the former if you don't wish to test your changes (_not recommended_!), and you won't need the latter if you don't touch anything under `_less` or `css`.

On OSX Lion I install ruby via rvm <https://rvm.beginrescueend.com/> per:

    bash -s stable < <(curl -s https://raw.github.com/wayneeseguin/rvm/master/binscripts/rvm-installer) 
    rvm install 1.9.3
    rvm use 1.9.3 --default
    gem install jekyll

and `node.js` with `lessc` via homebrew <http://mxcl.github.com/homebrew/> per:

    brew install node
    curl http://npmjs.org/install.sh | sh
    npm install -g less

These install `jekyll` and `lessc` in the following locations:

    $ which jekyll
    /Users/user/.rvm/gems/ruby-1.9.3-p125/bin/jekyll
    $ which lessc
    /usr/local/bin/lessc

