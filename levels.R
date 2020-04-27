# levelling factors
dat$test_results_2 <- fct_relevel(dat$test_results_2,
                                "Phenotypic markers reported (y)",
                                "Average value (n)",
                                "Tests done but not reported (t)",
                                "Stated as 'standard phenotype' (s)",
                                "Not discussed (o)")
dat$MOA <- fct_relevel(dat$MOA,
                       "Paracrine",
                       "Immune",
                       "Differentiation",
                       "Multiple",
                       "Not stated")

dat$stem_stromal <- fct_relevel(dat$stem_stromal,
                                "Stromal",
                                "Stem",
                                "Multipotent Stromal",
                                "Regenerative")

dat$funding <- fct_relevel(dat$funding,
                           "Commercial",
                           "National government",
                           "Regional government",
                           "Other grant",
                           "Mix",
                           "None",
                           "Not stated")

# turn year into a factor
dat$year <- factor(dat$year)
