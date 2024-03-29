context("test-ldtrait")

test_that("ldtrait throws an error for invalid input arguments", {
  skip_on_cran()
  skip_on_ci()
  expect_error(ldtrait(snps = "rs0", pop = "CEU",
                         token = Sys.getenv("LDLINK_TOKEN")
                        )
               )
  expect_error(ldtrait(snps = "rs4", pop = "CE",
                         token = Sys.getenv("LDLINK_TOKEN")
                         )
              )
  expect_error(ldtrait(snps = "rs0", r2d = "r",
                         token = Sys.getenv("LDLINK_TOKEN")
                         )
               )
  expect_error(ldtrait(snps = "rs456",
                       r2d = "r2",
                       token = Sys.getenv("LDLINK_TOKEN"),
                       genome_build = "grch999"
                      )
               )
  expect_error(ldtrait(snps = "rs456",
                       r2d = "r2",
                       token = Sys.getenv("LDLINK_TOKEN"),
                       genome_build = c("grch37", "grch38")
                      )
               )
})

test_that("ldtrait throws an error when thresholds are outside acceptable range", {
  skip_on_cran()
  skip_on_ci()
  expect_error(ldtrait(snps = "rs4", r2d_threshold = "99",
                         token = Sys.getenv("LDLINK_TOKEN")
                         )
                )
  expect_error(ldtrait(snps = "rs4", win_size = "9999999",
                         token = Sys.getenv("LDLINK_TOKEN")
                         )
                )
})

