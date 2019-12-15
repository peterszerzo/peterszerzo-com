<script>
  import Logo from "../components/Logo.svelte";
</script>

<footer>
  <div>
    <Logo />
  </div>
  <ul>
    <li><a href="https://represent.io/peterszerzo.pdf">Resume</a></li>
    <li><a href="https://twitter.com/peterszerzo">Twitter</a></li>
    <li>
      <a href="https://www.instagram.com/peterszerzo_/">Instagram</a>
    </li>
    <li><a href="https://github.com/peterszerzo">GitHub</a></li>
    <li><a href="https://dev.to/peterszerzo">Blog</a></li>
    <li><a href="./now">Now</a></li>
  </ul>
</footer>

<style>
footer {
  text-align: center;
}

footer ul {
  margin: 0;
}

footer ul {
  list-style: none;
  display: flex;
  align-items: center;
  justify-content: center;
}

footer ul a {
  margin-left: 18px;
}

footer :global(svg) {
  width: 36px;
  height: 36px;
  color: var(--sage);
}
</style>
