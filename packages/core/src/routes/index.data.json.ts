import sketchesRaw from "../db/sketches";
import frontMatter from "front-matter";
import glob from "glob";
import { fs } from "mz";

export const get = async (req, res, next) => {
  res.writeHead(200, {
    "Content-Type": "application/json",
  });

  const aboutSerious = (
    await fs.readFile("static/cms/about-serious.md")
  ).toString();

  const aboutAlternative = (
    await fs.readFile("static/cms/about-alternative.md")
  ).toString();

  // Projects

  const projectsFiles = await new Promise((resolve, reject) => {
    glob("static/cms/projects/*.md", (err, files) => {
      if (err) {
        reject(err);
      } else {
        resolve(files);
      }
    });
  });

  const projects = await Promise.all(
    projectsFiles.map(async (file) => {
      const content = (await fs.readFile(file)).toString();
      return { ...frontMatter(content).attributes };
    })
  );

  // Talks

  const talksFiles = await new Promise((resolve, reject) => {
    glob("static/cms/talks/*.md", (err, files) => {
      if (err) {
        reject(err);
      } else {
        resolve(files);
      }
    });
  });

  const talks = await Promise.all(
    talksFiles.map(async (file) => {
      const content = (await fs.readFile(file)).toString();
      return { ...frontMatter(content).attributes };
    })
  );

  // Sketches

  const sketches = sketchesRaw
    .filter((sketch) => sketch.public)
    .map((sketch) => ({
      slug: sketch.slug,
      title: sketch.title,
    }));

  res.end(
    JSON.stringify({
      sketches,
      projects,
      talks,
      aboutSerious,
      aboutAlternative,
    })
  );
};
