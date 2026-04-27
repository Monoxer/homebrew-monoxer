# Monoxer Monoxer

## How do I install these formulae?

* `brew tap Monoxer/monoxer`
* `brew install monoxer-adoptopenjdk8`
* (`brew install monoxer-temurin8`)
* `brew install monoxer-node`

## Documentation

`brew help`, `man brew` or check [Homebrew's documentation](https://docs.brew.sh).

## How to update a formula version

### 1. Edit the formula file

Open the relevant file under `Formula/` and update `url` and `sha256`.

#### GitHub Releases (e.g. `monoxer-ktlint.rb`)

```ruby
url "https://github.com/pinterest/ktlint/releases/download/X.Y.Z/ktlint-X.Y.Z.zip"
sha256 "<sha256 of the zip>"
```

To get the sha256:

```bash
curl -sL <url> | shasum -a 256
```

#### npm (e.g. `degit.rb`)

```ruby
url "https://registry.npmjs.org/degit/-/degit-X.Y.Z.tgz"
sha256 "<sha256 of the tarball>"
```

To get the sha256:

```bash
curl -sL <url> | shasum -a 256
```

### 2. Open a pull request

Push the branch and open a PR. CI (`brew test-bot`) will automatically build bottles for each supported platform and upload them as artifacts.

### 3. Merge with bottle

Once CI passes, add the **`pr-pull`** label to the PR. This triggers the publish workflow (`brew pr-pull`), which:

1. Downloads the built bottles from CI artifacts
2. Updates the `bottle do` block in the formula
3. Merges the commit into `main` and deletes the branch
