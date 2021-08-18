compileAssignmentHtml_iframe <- function(path, envir = new.env(parent = .GlobalEnv), ...){
  tmpfn = tempfile(fileext = ".html")
  input = file.path(path, "index.Rmd")
  output_format = rmarkdown::html_document(pandoc_args = c("--metadata", "title= " ) )
  knitr::knit_hooks$set(seed.status = flexTeaching::seedStatusHook)
  rmarkdown::render(input = input, output_format = output_format, output_file = tmpfn,
                    intermediates_dir = dirname(tmpfn),
                    envir = envir, quiet = TRUE, ...)
  tmpfn |>
    readLines(warn = FALSE, encoding = 'UTF-8') |>
    paste(collapse="\n") |>
    htmltools::HTML() -> content
  htmltools::tags$iframe(srcdoc = content,
                         class = 'ft_iframe') |>
    as.character() |>
    cat("\n", file = tmpfn)
  return(tmpfn)
}
