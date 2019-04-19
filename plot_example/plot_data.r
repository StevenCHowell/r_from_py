library(ggplot2)
library(readr)
library(getopt)
library(argparse)


parser <- ArgumentParser(description='Plot a 2-column csv file.')
parser$add_argument('fname', help='full file name, including relative path, to data file')
args = parser$parse_args()

fname_fig <- gsub('csv', 'png', args$fname)
data = read_csv(args$fname, col_types=cols())
png(file=fname_fig)
ggplot(data, aes(x=`0`, y=`1`)) + geom_line(color='#258bd2') + ggtitle(basename(args$fname))
