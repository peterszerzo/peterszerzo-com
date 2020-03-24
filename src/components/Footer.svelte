<script>
  import Logo from "../components/Logo.svelte";
</script>

<footer>
  <div class="footer-content">
    <div class="footer-logo">
      <p>2020 Peter Szerzo</p>
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
  </div>
</footer>

<style>
footer {
  border-top: 3px dotted var(--sage);
  padding: 60px 0;
}

@media (min-width: 640px) {
  footer {
    border-top: 4px dotted var(--sage);
  }
}

.footer-content {
  max-width: 800px;
  padding: 0 15px;
  margin: auto;
}

p {
  margin: 0 0 10px 0;
}

ul {
  margin: 0;
}

li {
  display: inline-block;
  margin: 0 18px 6px 0;
}

ul {
  list-style: none;
}

.footer-logo {
  height: 36px;
  margin: auto;
}
</style>
