<nav>
  <a href="/drawing-1">Drawing 1</a>
  <a href="/drawing-2">Drawing 2</a>
</nav>

<style>
  nav {
    position: absolute;
  }

  nav > * + * {
    margin-left: 8px;
  }

  a {
    display: inline-block;
    text-decoration: underline;
    color: inherit;
    border-radius: 6px;
  }

  main {
    margin-top: 20px;
  }
</style>
