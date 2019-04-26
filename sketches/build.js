const { exec } = require("child_process");
const fs = require("fs");

const execPromise = cmd =>
  new Promise((resolve, reject) => {
    exec(cmd, (err, stdout, stderr) => {
      if (err || stderr) {
        reject(err || stderr);
        return;
      }
      resolve();
    });
  });

const sketches = [
  {
    file: "01",
    slug: "stick-parade",
    title: "Stick Parade"
  },
  {
    file: "02",
    slug: "uncomfortable",
    title: "Uncomfortable"
  },
  {
    file: "03",
    slug: "postits",
    title: "Postits"
  },
  {
    file: "04",
    slug: "twist-study",
    title: "Twist Study"
  }
];

const writePromise = (file, data) => {
  fs.writeFileSync(file, data);
  return Promise.resolve();
};

const cmds = [
  "rm -rf tmp",
  "mkdir tmp",
  ...sketches
    .map(sketch => [
      `sed 's/\{\{title\}\}/${
        sketch.title
      }/g' template.html > tmp/template.html`,
      `canvas-sketch src/${
        sketch.file
      }.js --build --inline --dir tmp --html tmp/template.html`,
      `mv tmp/${sketch.file}.html tmp/${sketch.slug}.html`
    ])
    .reduce((acc, curr) => [...acc, ...curr], []),
  "rm tmp/template.html",
  "mv tmp ../sites/peterszerzo-com/build/sketches"
];

execPromise(cmds.join(" && "))
  .then(() => {
    console.log("success");
  })
  .catch(err => {
    console.log(err);
  });
