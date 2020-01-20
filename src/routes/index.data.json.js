import sketchesRaw from "../db/sketches.js";
import frontMatter from "front-matter";
import glob from "glob";
import { fs } from "mz";

export const get = async (req, res, next) => {
  res.writeHead(200, {
    "Content-Type": "application/json"
  });

  const aboutSerious = (await fs.readFile(
    "static/cms/about-serious.md"
  )).toString();

  const aboutAlternative = (await fs.readFile(
    "static/cms/about-alternative.md"
  )).toString();

  // Projects

  const projects = await new Promise((resolve, reject) => {
    glob("static/cms/projects/*.md", (err, files) => {
      if (err) {
        reject(err);
      } else {
        resolve(files);
      }
    });
  });

  const projectContents = await Promise.all(
    projects.map(async project => {
      const content = (await fs.readFile(project)).toString();
      return { ...frontMatter(content).attributes };
    })
  );

  // Sketches

  const sketches = sketchesRaw.filter(sketch => sketch.public).map(sketch => ({
    slug: sketch.slug,
    title: sketch.title
  }));

  res.end(
    JSON.stringify({
      sketches,
      projects,
      aboutSerious,
      aboutAlternative
    })
  );
};
