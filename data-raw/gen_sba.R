set.seed(811)
rnd <- rnorm(4, sd= 0.4);rnd[1] <- 0
rnds <- rnorm(384, sd= 0.5)
rndab <- rnorm(100, sd= 2)
tg <- sapply(1:100, function(ii) rnds + rndab[ii] + rep(rnd + rnorm(4, sd= abs(rnorm(1, sd= 0.1))), each= 96) + rnorm(384, sd= 0.1))
tg <- exp(tg/(max(tg) - min(tg))*(log(sample(19000:22000, 1)) - log(sample(190:220, 1))))*2000
tg <- round(tg)
geomean <- function(x) exp(mean(log(x)))
tg_plate <- factor(rep(paste("plate", c("1", "2", "3", "4")), each= 96))
tgm <- by(tg, tg_plate, apply, 2, geomean)
par(mfrow= c(2, 3))
apply(combn(4, 2), 2, function(ea) {
	plot(tgm[[ea[1]]], tgm[[ea[2]]], xlab= names(tgm)[ea[1]], ylab= names(tgm)[ea[2]], log= "xy", asp= 1)
	abline(0, 1, col= "cadetblue")
})
print(tg[c(1:10, 97:106), 1:10])

colnames(tg) <- paste("T", 1:100, sep= "")
rownames(tg) <- paste("S", 1:384, sep= "")

sba <- list("plate"= tg_plate, "X"= tg)
devtools::use_data(sba1, pkg= "MDimNormn", overwrite= TRUE)

