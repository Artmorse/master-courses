# Master Courses

## Requirements

- nodejs
- npm
- [reveal-md](https://github.com/webpro/reveal-md)

## Reveal-MD Installation

```bash
pacman -Sy node npm
npm install -g npm@latest
npm -v

npm install -g reveal-md
```

## Usage

### Server mode

**reveal-md** have a server version.

#### Docker

```bash
docker run --rm -p 1948:1948 -p 35729:35729 -v ${PWD}/markdown:/slides webpronl/reveal-md:latest ./ --watch --css ./style.css --listing-template ./listing.html
```

### Export to PDF

Run the server.

```bash
docker run --rm -p 1948:1948 -p 35729:35729 -v ${PWD}/markdown:/slides webpronl/reveal-md:latest ./ --watch --css ./style.css --listing-template ./listing.html
```

Export the slides.

```bash
mkdir exports;
for slide in `find ./markdown/ -name "session-*.md" -printf "%f\n" | awk -F'.' '{print $1}'`; do
docker run --rm -t --net=host -v $PWD:/slides astefanutti/decktape -s 1024x1024 "http://localhost:1948/${slide}.md#/" ./exports/${slide}.pdf;
done
```

### Convert to HTML files

```bash
docker run --rm -v ${PWD}:/slides webpronl/reveal-md:latest ./markdown --static public/ --static-dirs=markdown/img/ --css markdown/style.css --listing-template markdown/listing.html
```

This command convert the markdowns to HTML files.
The convertion generates a [public](public/) directory.

## Helpfull links

- [RevealMD Github Repository](https://github.com/webpro/reveal-md)
