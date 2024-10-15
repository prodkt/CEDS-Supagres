![CEDS 12 - Adapted for Supabase](/apps/astro/public/CEDS-12_SUPAGRES.webp "CEDS 12 - Adapted for Supabase")

> [!NOTE]
>
> # CEDS 12 Supagres Adaptation
>
> ```
> I do not work for and am not affiliated with CEDS in any capacity.
> ```
>
> <sup>This repo is not maintained through any release cycle. This is a personal project to benefit my more exciting and fun side projects. Although if you are planning on building in the technologies I've used here, and with the CEDS model I'm always very interested in EdTech projects that decide on truly great technology as a backbone to build upon. And if you too have a history in EdTech, you've likely used some very antiquated and outdated systems. I refuse to believe and adopt the mindset that EdTech, the LMS or LXP only need reach a level to meet competitors in the space or what learners today are used to seeing. We should all strive to build future forward learning experiences, and have the technology of today, now -- so that we can move at pace to truly make change in Education technology.</sup>
>
> <sub>Bryan Funk</sub>

> [!IMPORTANT]
>
> ### :mortar_board: Goals and status
>
> ## Create, configure, and deploy project as a public GitHub repo
>
> - [x] Supabase
>
> - <sup>Development will happen solely on local containers for speed, ease of testing, QA, and because at the moment hitting project milestones on projects dependant on this will quickly be at risk if if a downtick in velocity occured.</sup>
>
> - [x] Directus
>
> - <sup>Development will happen solely on local containers for speed, ease of testing, QA, and because at the moment hitting project milestones on projects dependant on this will quickly be at risk if if a downtick in velocity occured.</sup>
>
> - [x] Parity project tooling on both Windows & Mac devices
>
> - <sup>Stream Llama 3.1 (Pair programmer), Directus (CMS), and Supabase (Data, DB) over local network. Many tasks in this project wont require I be in the office at my desk, e.g. Model testing and endpoint creation can easily be done by iPad from the couch.</sup>
>
> - [x] Transformation of CEDS ddl
>
> - <sup>Essential, this is a rock and also most immediate need in order to complete the next requirement and for api route creation.</sup>
>
> - [ ] Transformation and implementation of CEDS Element tables into Supabase
>
> - <sup>As Supabase migration.</sup>
>
> - [ ] Transformation and implementation of CEDS Ref tables into Supabase
>
> - <sup>As Supabase migration.</sup>
>
> - [ ] Set RLS on CEDS model to Public (temporary)
>
> - [ ] Research and Planning of CEDS access policies into Postgres RLS
>
> - <sup>Critical, but not needed immediately. By the time I arrive at this my hope is to have persuaded someone working within CEDS to have a cup of coffee with me over Zoom to see if I'm reletively on course having never directly worked with this model or if a course correction is needed.</sup>
>
> - [ ] Release a working prototype  :tada:
>
> - <sup>Course experience as a learner. Option to Seed demo data but will plan this after running through how CEDS dummy data implementation goes.</sup>
> - <sup>CEDS model using Directus CMS as the Administrative UI with of course the model running with Supabase/Postgres.</sup>
>

> [!NOTE]
> ## What's inside?
> This Turborepo monorepo includes the following packages/apps:
> 
> ### Apps and Packages
> 
> - `@prodkt/ui`: a stub React component library to be shared by all demo applications
> - `@prodkt/eslint-config`: `eslint` configurations (includes `eslint-config-next` and `eslint-config-prettier`)
> - `@prodkt/typescript-config`: `tsconfig.json`s used throughout the monorepo
> 
> Each package/app is 100% [TypeScript](https://www.typescriptlang.org/).
>
> 
> ### Styles
> - `@prodkt/astro-radix-tailwind`: a custom implementation of Tailwind V4 Alpha.26 will be used throughout every project. It is and will be its own package this monorepo will use as a dependency, although for now these files can be found inside this monorepo. More information on what's in store will come soon enough and far before a demo is release. But do take note of the frontend tech I plan to use in case you're unfamiliar
> 
> ![CEDS 12 - Adapted for Supabase](/apps/astro/public/ASTRO_RADIX_TAILWIND.webp "CEDS 12 - Adapted for Supabase")



> [!NOTE]
> ### Utilities
> 
> - [TypeScript](https://www.typescriptlang.org/) for static type checking
> - [ESLint](https://eslint.org/) for code linting
> - [Prettier](https://prettier.io) for code formatting

> [!TIP]
> ### Build
> 
> To build all apps and packages, run the following command:
> 
> ```
> cd CEDS-Supagres
> pnpm build
> ```

> [!TIP]
> ### Develop
> 
> To develop all apps and packages, run the following command:
> 
> ```
> cd CEDS-Supagres
> pnpm dev
> ```

> [!TIP]
> ### Remote Caching
> 
> Turborepo can use a technique known as [Remote Caching](https://turbo.build/repo/docs/core-concepts/remote-caching) to share cache artifacts across machines, enabling you to share build caches with your team and CI/CD pipelines.
> 
> By default, Turborepo will cache locally. To enable Remote Caching you will need an account with Vercel. If you don't have an account you can [create one](https://vercel.com/signup), then enter the following commands:
> 
> ```
> cd CEDS-Supagres
> npx turbo login
> ```
> 
> This will authenticate the Turborepo CLI with your [Vercel account](https://vercel.com/docs/concepts/personal-accounts/overview).
> 
> Next, link CEDS-Supagres to your Remote Cache by running the following command from the root:
> 
> ```
> npx turbo link
> ```

## Useful Links

Learn more about the power of Turborepo:

- [Tasks](https://turbo.build/repo/docs/core-concepts/monorepos/running-tasks)
- [Caching](https://turbo.build/repo/docs/core-concepts/caching)
- [Remote Caching](https://turbo.build/repo/docs/core-concepts/remote-caching)
- [Filtering](https://turbo.build/repo/docs/core-concepts/monorepos/filtering)
- [Configuration Options](https://turbo.build/repo/docs/reference/configuration)
- [CLI Usage](https://turbo.build/repo/docs/reference/command-line-reference)
