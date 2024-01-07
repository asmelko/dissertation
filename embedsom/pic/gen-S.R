
set.seed(1)
n <- 10000
phiX <- runif(n)
phi <- 2*phiX-1

pos <- function(p) {
  pp <- 3*pi*abs(p)/2
  sign(p)*cbind(1-cos(pp), sin(pp))
}

d <- cbind(x=-1.44*pos(phi)[,2], y=3*runif(n), z=pos(phi)[,1])
col <- viridisLite::plasma(50)[1+49*phiX]

write.table(d, 'S.tsv', row.names=F, col.names=T, quote=F, sep='\t')

png('S.png', 800, 1024, res=200) #Just the 3D picture of the S dataset
par(mar=c(0,0,0,0))
plot3D::scatter3D(d[,1], d[,2], d[,3], colvar=NULL, legend=F, theta=20, phi=20, pch=19, cex=.3, col=col, scale=F)
dev.off()

# now you go to blossom and embed all the stuff

dd <- read.table('s_som/points_hd.tsv')
codes <- read.table('s_som/landmarks_hd.tsv')
png('S_som_hd.png', 800, 1024, res=200)
par(mar=c(0,0,0,0))
plot3D::scatter3D(dd[,1], dd[,2], dd[,3], colvar=NULL, legend=F, theta=20, phi=20, pch=19, cex=.3, col=col, scale=F)
plot3D::scatter3D(codes[,1], codes[,2], codes[,3], add=T, colvar=NULL, pch=19, cex=2)
dev.off()

dd <- read.table('s_som/points_2d.tsv')
codes <- read.table('s_som/landmarks_2d.tsv')
png('S_som_2d.png', 1024, 1024, res=200)
par(mar=c(0,0,0,0))
plot(rbind(dd,as.matrix(codes)), pch='', frame.plot=F, xaxt='n', yaxt='n')
points(dd, pch=19, cex=.3, col=col)
points(codes, pch=19, cex=2)
dev.off()

dd <- read.table('s_graph/points_hd.tsv')
codes <- read.table('s_graph/landmarks_hd.tsv')
kns <- cbind(seq_len(nrow(codes)), FNN::get.knn(codes, k=3)$nn.index)
kns <- rbind(kns[,c(1,2)],kns[,c(1,3)],kns[,c(1,4)]) 
png('S_graph_hd.png', 800, 1024, res=200)
par(mar=c(0,0,0,0))
plot3D::scatter3D(dd[,1], dd[,2], dd[,3], colvar=NULL, legend=F, theta=20, phi=20, pch=19, cex=.3, col=col, scale=F)
plot3D::scatter3D(codes[,1], codes[,2], codes[,3], add=T, colvar=NULL, pch=19, cex=2)
for(i in seq_len(nrow(kns)))
  plot3D::lines3D(codes[kns[i,],1], codes[kns[i,],2], codes[kns[i,],3], add=T, colvar=NULL, lwd=3)
dev.off()

dd <- read.table('s_graph/points_2d.tsv')
codes <- read.table('s_graph/landmarks_2d.tsv')
png('S_graph_2d.png', 1024, 1024, res=200)
par(mar=c(0,0,0,0))
plot(rbind(dd,as.matrix(codes)), pch='', frame.plot=F, xaxt='n', yaxt='n')
points(dd, pch=19, cex=.3, col=col)
for(i in seq_len(nrow(kns)))
  lines(codes[kns[i,],1], codes[kns[i,],2], lwd=3)
points(codes, pch=19, cex=2)
dev.off()

dda <- rbind(
  read.table('s_begin/points_2d.tsv'),
  read.table('s_mid/points_2d.tsv'),
  read.table('s_end/points_2d.tsv'))
dd <- read.table('s_begin/points_2d.tsv')
codes <- read.table('s_begin/landmarks_2d.tsv')
png('S_begin_2d.png', 1024, 1024, res=200)
par(mar=c(0,0,0,0))
plot(dda, pch='', frame.plot=F, xaxt='n', yaxt='n')
points(dd, pch=19, cex=.3, col=col)
points(codes, pch=19, cex=2)
dev.off()

dd <- read.table('s_mid/points_2d.tsv')
codes <- read.table('s_mid/landmarks_2d.tsv')
png('S_mid_2d.png', 1024, 1024, res=200)
par(mar=c(0,0,0,0))
plot(dda, pch='', frame.plot=F, xaxt='n', yaxt='n')
points(dd, pch=19, cex=.3, col=col)
points(codes, pch=19, cex=2)
dev.off()

dd <- read.table('s_end/points_2d.tsv')
codes <- read.table('s_end/landmarks_2d.tsv')
png('S_end_2d.png', 1024, 1024, res=200)
par(mar=c(0,0,0,0))
plot(dda, pch='', frame.plot=F, xaxt='n', yaxt='n')
points(dd, pch=19, cex=.3, col=col)
points(codes, pch=19, cex=2)
dev.off()
