import "./webcomponents";

import { router } from "./200";

if (process.env.NODE_ENV === "development") {
  router();
}
