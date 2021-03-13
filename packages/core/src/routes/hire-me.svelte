<Hero title="Hire Me" after="for #webdev, #ux, #dataviz, #3d and more" />

{#if false}
  <svg width="400" height="400" viewBox="0 0 500 500">
    <path id="curve1" d="M50,100c120,0,240,160,360,160" fill="none" />
    <text width="500" font-size="50" letter-spacing="4">
      <textPath alignment-baseline="top" xlink:href="#curve1">
        Peter’s Famous
      </textPath>
    </text>
    <path id="curve2" transform="translate(0 100)" d="M80,300c80,0,160,-120,240,-120" fill="none" />
    <text width="500" font-size="28" letter-spacing="1">
      <textPath alignment-baseline="top" xlink:href="#curve2">
        Computer Programs
      </textPath>
    </text>
  </svg>
{/if}

<Section>
  <SectionTitle title="Services" />
  <Static md={servicesMd} />
</Section>

<Section>
  <SectionTitle title="Clients" />
  <Static md={clientsMd} />
</Section>
<Section>
  <SectionTitle title="Work Ethic" />
  <Static md={workEthicMd} />
</Section>
<Section>
  <SectionTitle title="Is this up your alley?" />
  <Static md={contactMd} />
</Section>

<script>
  import Hero from "../components/Hero.svelte";
  import Section from "../components/Section.svelte";
  import SectionTitle from "../components/SectionTitle.svelte";
  import HireMeAnimation from "../components/HireMeAnimation.svelte";
  import Static from "../components/Static.svelte";

  let servicesMd = `
* Frontend development in React, Elm, Vue, Svelte or the framework of your choice.
* Data visualization in d3, Vega or any of the frameworks above.
* 3d applications in the browser.
* Consulting and code reviews for software architecture with focus on a typed functional style (TypeScript, Elm, PureScript).
* UX design, prototyping and user testing.
`;

  let clientsMd = `
* [NLX](https://nlx.ai/), New York.
* [Open Systems Lab](https://www.opensystemslab.io/), London.
* [Chefclub](https://www.chefclub.tv/en-us/), Paris.
* [Project Together](https://projecttogether.org/), Berlin.
`;

  let workEthicMd = `
* Absolutely no overengineering or speculation.
* Excellent communication, follow-through and initiative where appropriate.
* Secure, correct, intuitive, fast and beautiful end results, in roughly that order.
`;

  let contactMd = `
I am excited [to hear from you](mailto:szerzo.peter@gmail.com).

If you live in Berlin or passing by, let’s hang out over coffee or lunch.
`;
</script>
