# TIDY
# levelling factors
dat$test_results <- fct_relevel(dat$test_results,
                                "1. % by batch reported",
                                "2. Average % reported",
                                "3. Tests done but % not reported",
                                "4. Stated as 'standard phenotype'",
                                "5. No characterisation discussed")
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

dat$O <- fct_relevel(dat$O,
                     "Not mentioned",
                     "Performed, no value reported",
                     "Performed, value reported")

dat$A <- fct_relevel(dat$A,
                     "Not mentioned",
                     "Performed, no value reported",
                     "Performed, value reported")

dat$C <- fct_relevel(dat$C,
                     "Not mentioned",
                     "Performed, no value reported",
                     "Performed, value reported")
dat$other <- fct_relevel(dat$other,
                         "Not mentioned",
                         "Performed, no value reported",
                         "Performed, value reported")

# turn year into a factor
dat$year <- factor(dat$year)

# turn ref in to a factor
dat$ref_number <- factor(dat$ref_number) 