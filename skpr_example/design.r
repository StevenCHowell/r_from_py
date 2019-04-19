library(argparse)
library(glue)
source("skpr_wrapper.r")

parser <- ArgumentParser(description='Explore DOE design sizing using these inputs')
parser$add_argument('-n', '--n_plots', type='integer',
                          default=4, help='Number of subplots.')
parser$add_argument('-s', '--plot_size', type='integer',
                          default=10, help='Size of each subplot.')
args <- parser$parse_args()

# easy to change factors
x_levels <- c(0, 1, 2, 3, 4)
y_levels <- c('y1', 'y2', 'y3', 'y4')

# hard to change factors
i_levels <- c(-1, 0, 1)
j_levels <- c('a', 'b', 'c')

# define the factor levels
candidate_set <- expand.grid(
    x = x_levels,
    y = y_levels,
    i = i_levels,
    j = j_levels
)

# remove any disallowed combinations
candidate_set <- subset(
    candidate_set,
    !(x %in% c(4) & i %in% c(-1)) &  # these could be more complicated
    !(y %in% c('y1') & j %in% c('a'))
)

# define the formulas that will be used
model_htc <- ~i + j
model_design <- ~i + j + x + y +
                 I(x^2) + I(x^3)
model_me <- ~i + j + x + y
model_tfi <- ~i + j + x + y +
              x:i + y:i
model_alias <- ~x:y + x:j + y:j

model <- list(
    htc = model_htc,
    me = model_me,
    tfi = model_tfi,
    design = model_design,
    alias = model_alias
)

generate_design(candidate_set, model, args$n_plots, args$plot_size)
