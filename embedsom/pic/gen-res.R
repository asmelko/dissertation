
d <- read.table("mamut.tsv")
col <- d[,3]
col = col-min(col)
col = col/max(col)
col = viridisLite::turbo(100, alpha=.3)[1+99*col]

e <- read.table("mamut1/points_2d.tsv")
grid <- read.table("mamut1/landmarks_2d.tsv")

png('mamut1.png', 1024, 1024)
par(mar=c(0,0,0,0))
plot(e, pch='', frame.plot=F, xaxt='n', yaxt='n')
points(e, pch='.', col=col)
points(grid, pch=19, cex=2, col=rgb(0,0,0,0.3))
dev.off()

codes <- read.table("mamut2/landmarks_hd.tsv")
kns <- cbind(seq_len(nrow(codes)), FNN::get.knn(codes, k=3)$nn.index)
kns <- rbind(kns[,c(1,2)],kns[,c(1,3)],kns[,c(1,4)]) 

e <- read.table("mamut2/points_2d.tsv")
grid <- read.table("mamut2/landmarks_2d.tsv")

png('mamut2.png', 1024, 1024)
par(mar=c(0,0,0,0))
plot(e, pch='', frame.plot=F, xaxt='n', yaxt='n')
points(e, pch='.', col=col)
points(grid, pch=19, cex=2, col=rgb(0,0,0,0.3))
for(i in seq_len(nrow(kns)))
  lines(grid[kns[i,],1], grid[kns[i,],2], lwd=2, col=rgb(0,0,0,0.3))
dev.off()

d <- flowCore::read.FCS("Samusik_all.fcs", truncate_max_range=F)@exprs
cl <- read.table("samusik-manual-labels.tsv")[,1]
cl <- EmbedSOM::ClusterPalette(max(cl), alpha=.3)[cl]

e <- read.table("samusik_rough/points_2d.tsv")
grid <- read.table("samusik_rough/landmarks_2d.tsv")
png('samusik1.png', 1024, 768)
par(mar=c(0,0,0,0))
plot(e, pch='', frame.plot=F, xaxt='n', yaxt='n', ylim=quantile(e[,2], c(0.001, 0.999)))
points(e, pch='.', col=cl)
points(grid, pch=19, cex=2, col=rgb(0,0,0,0.3))
dev.off()

e <- read.table("samusik_sep1/points_2d.tsv")
grid <- read.table("samusik_sep1/landmarks_2d.tsv")
png('samusik2.png', 1024, 768)
par(mar=c(0,0,0,0))
plot(e, pch='', frame.plot=F, xaxt='n', yaxt='n', xlim=quantile(e[,1], c(0.001, 0.999)), ylim=quantile(e[,2], c(0.001, 0.999)))
points(e, pch='.', col=cl)
points(grid, pch=19, cex=2, col=rgb(0,0,0,0.3))
dev.off()

codes <- read.table("samusik_sep2/landmarks_hd.tsv")
kns <- cbind(seq_len(nrow(codes)), FNN::get.knn(codes, k=3)$nn.index)
kns <- rbind(kns[,c(1,2)],kns[,c(1,3)],kns[,c(1,4)]) 

e <- read.table("samusik_sep2/points_2d.tsv")
grid <- read.table("samusik_sep2/landmarks_2d.tsv")
png('samusik3.png', 1024, 768)
par(mar=c(0,0,0,0))
plot(e, pch='', frame.plot=F, xaxt='n', yaxt='n', ylim=quantile(e[,2], c(0.001, 0.999)))
points(e, pch='.', col=cl)
points(grid, pch=19, cex=2, col=rgb(0,0,0,0.3))
for(i in seq_len(nrow(kns)))
  lines(grid[kns[i,],1], grid[kns[i,],2], lwd=2, col=rgb(0,0,0,0.3))
dev.off()

flt <- e[,1]>=5 & e[,1]<=9.1 & e[,2]>=0.5 & e[,2]<=4.5
for(i in c('CD4','CD8','CD49b','CD44','CD25','Ly6C','Sca1')) {
  png(paste0('samusik-zoom-',i,'.png'), 1024, 1024)
  par(mar=c(0,0,0,0))
  EmbedSOM::PlotEmbed(e[flt,], frame.plot=F, data=d[flt,], xaxs='i', yaxs='i', pch=16, cex=.5, alpha=.5, i)
  dev.off()
}
