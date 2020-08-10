<Hero title="Peter’s Famous Computer Programs" after="Hire me for #webdev, #ux, #dataviz, #3d and more" />

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
  import Static from "../components/Static.svelte";

  let servicesMd = `
* Frontend development in React, Elm, Vue, Svelte or the framework of your choice.
* Data visualization using d3, Vega or a general-purpose frontend framework.
* 3d applications in the browser.
* Consulting and code reviews for application architecture with focus on a typed functional style (TypeScript, Elm, PureScript).
* UX design, prototyping and user testing.
`;

  let clientsMd = `
* [NLX](https://nlx.ai/), New York.
* [Open Systems Lab](https://www.opensystemslab.io/), London.
* [Chefclub](https://www.chefclub.tv/en-us/), Paris.
* [Project Together](https://projecttogether.org/), Berlin.
`;

  let workEthicMd = `
I produce web projects that are secure, correct, intuitive, fast and beautiful - in that order. I offer the following:

* Excellent communication throughout.
* No overengineering, no speculation.
* Need an ear for your design process or someone to fill the gaps?
`;

  let contactMd = `
[I am excited to hear from you.](mailto:szerzo.peter@gmail.com)
`;
</script>
