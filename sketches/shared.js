export const setContainerStyles = ({ size, animating }) => el => {
  el.style.width = size + "px";
  el.style.height = size + "px";
  el.style.transition = "box-shadow 0.1s ease-in-out";
  el.style.borderRadius = "3px";
  el.style.cursor = "pointer";
  el.style.overflow = "hidden";
  if (animating) {
    el.style.boxShadow = "0 0 2px 0 rgba(0, 0, 0, 0.5)";
  } else {
    el.style.boxShadow = "0 0 10px 0 rgba(0, 0, 0, 0.3)";
  }
};
