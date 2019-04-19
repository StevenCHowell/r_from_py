library(skpr)
library(readr)
library(glue)

optimality = 'Alias'

generate_design <- function(candidate_set, model, n_plots, plot_size){
    n_runs <- n_plots * plot_size
    if(!dir.exists('output')){dir.create('output')}

    fname_base <- glue('output/n{n_runs}_s{n_plots}_rps{plot_size}')
    cat(glue('creating design for {n_plots} plots with {plot_size} runs per plot...\n'))

    # generate the design for the hard-to-change factors
    design_htc <- gen_design(
        candidateset = candidate_set,
        model = model$htc,
        trials = n_plots,
        optimality = optimality
    )

    # generate the full design
    design <- gen_design(
        candidateset = candidate_set,
        model = model$design,
        splitplotdesign = design_htc,
        splitplotsizes = plot_size,
        trials = n_runs,
        optimality = optimality,
        parallel = TRUE
    )
    fname_design <- glue('{fname_base}_design.csv')
    write_csv(design, fname_design, append=FALSE)

    # evaluate the design using Monte Carlo simulation
    design_eval <- eval_design_mc(
        design = design,
        model = model$me,
        alpha = 0.05,
        effectsize = 2.0,
        glmfamily = 'gaussian',
        blocking = TRUE,
        parallel = TRUE
    )
    fname_eval <- glue('{fname_base}_eval.csv')
    write_csv(design_eval, fname_eval, append=FALSE)

    # plot the correlations
    fname_plot_me <- gsub('.csv', '_me.png', fname_eval)
    png(filename = fname_plot_me, width=350, height=350, antialias = 'cleartype')
    plot_correlations(
        design_eval,
        model = model$me,
        customcolors = c('blue', 'grey', 'red')
    )
    dev.off()

    fname_plot_tfi <- gsub('.csv', '_2fi.png', fname_eval)
    png(filename = fname_plot_tfi, width=1050, height=950, antialias = 'cleartype')
    plot_correlations(
        design_eval,
        model = model$tfi,
        customcolors = c('blue', 'grey', 'red')
    )
    dev.off()

    cat('done.\n\n')
}
