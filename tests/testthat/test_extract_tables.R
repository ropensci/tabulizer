context("Minimum functionality of extract_tables")

sf <- system.file("examples", "data.pdf", package = "tabulizer")

test_that("It basically works", {
    tab1 <- extract_tables(sf)
    expect_true(is.list(tab1))
    expect_true(is.matrix(tab1[[1]]))
})

test_that("Test 'guess' argument", {
    tab1a <- extract_tables(sf, pages = 1, guess = TRUE)
    tab1b <- extract_tables(sf, pages = 1, guess = FALSE)
    expect_true(ncol(tab1a[[1]]) == 10)
    expect_true(ncol(tab1b[[1]]) == 13)
    
    tab2a <- extract_tables(sf, pages = 2, guess = TRUE)
    tab2b <- extract_tables(sf, pages = 2, guess = FALSE)
    expect_true(length(tab2a) == 2)
    expect_true(length(tab2b) == 1)
})

test_that("Import from remote file works", {
    f2 <- "https://github.com/tabulapdf/tabula-java/raw/master/src/test/resources/technology/tabula/12s0324.pdf"
    tab2 <- extract_tables(f2)
    expect_true(is.list(tab2))
    expect_true(length(tab2) == 2)
    expect_true(is.matrix(tab2[[1]]))
})

test_that("Import from remote non-Western file", {
    f3 <- "https://github.com/tabulapdf/tabula-java/raw/master/src/test/resources/technology/tabula/arabic.pdf"
    tab3 <- extract_tables(f3)
    expect_true(is.list(tab3))
    expect_true(length(tab3) == 1)
    expect_true(is.matrix(tab3[[1]]))
})

test_that("Test 'area' argument", {
    a4a <- list(c(122, 149, 536, 576))
    tab4a <- extract_tables(sf, pages = 1, area = a4a, guess = FALSE, method = "data.frame")
    expect_true(is.list(tab4a))
    expect_true(is.data.frame(tab4a[[1]]))
    expect_true(nrow(tab4a[[1]]) == 32)
    expect_true(ncol(tab4a[[1]]) == 12)
    a4b <- list(c(122, 149, 251, 464))
    tab4b <- extract_tables(sf, pages = 1, area = a4b, guess = FALSE, method = "data.frame")
    expect_true(is.list(tab4b))
    expect_true(is.data.frame(tab4b[[1]]))
    expect_true(nrow(tab4b[[1]]) == 9)
    expect_true(ncol(tab4b[[1]]) == 8)
})

test_that("Test 'columns' argument", {
    tab5 <- extract_tables(sf, pages = 1, columns = list(c(0, 612)), guess = FALSE)
    expect_true(is.list(tab5))
    expect_true(length(tab5) == 1)
    expect_true(ncol(tab5[[1]]) == 2)
    expect_true(nrow(tab5[[1]]) == 34)
})