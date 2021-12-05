<script lang="ts">
  import Logo from "../components/Logo.svelte";
</script>

<footer>
  <div class="footer-content">
    <div class="footer-logo">
      <Logo />
    </div>
    <div>
      <p>2021 Peter Szerzo</p>
    </div>
    <ul>
      <li>
        <a href="https://represent.io/peterszerzo.pdf"><small>Resume</small></a>
      </li>
      <li>
        <a href="https://twitter.com/peterszerzo"><small>Twitter</small></a>
      </li>
      <li>
        <a href="https://www.instagram.com/peterszerzo_/"
          ><small>Instagram</small></a
        >
      </li>
      <li>
        <a href="https://github.com/peterszerzo"><small>GitHub</small></a>
      </li>
      <li><a href="https://dev.to/peterszerzo"><small>Blog</small></a></li>
      <li><a href="/hire-me"><small>Hire me✨</small></a></li>
      <li><a href="/now"><small>Now</small></a></li>
    </ul>
  </div>
</footer>

<style>
  footer {
    border-top: 3px dotted #dedede;
    padding: 60px 0;
    text-align: center;
  }

  @media (min-width: 640px) {
    footer {
      border-top: 4px dotted #dedede;
    }
  }

  .footer-logo {
    width: 36px;
    height: 36px;
    color: #cecece;
  }

  .footer-content {
    max-width: 800px;
    padding: 0 15px;
    margin: auto;
  }

  .footer-content > :global(*) + :global(*) {
    margin-top: 16px;
  }

  p {
    margin: 0 0 10px 0;
  }

  ul {
    margin: 0;
  }

  li {
    display: inline-block;
    margin: 0;
  }

  li + li {
    margin-left: 12px;
  }

  ul {
    list-style: none;
  }

  .footer-logo {
    height: 36px;
    margin: auto;
  }
</style>
