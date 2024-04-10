source("HW_09_Functions")


x <- fakedata(nGroup = 3, nName = c("Control","Low", "High"), nSize = c(30,27,25), nMean = c(68.37,51.15,30.46),nSD = c(16.58,19.05,12.84), ID = 1:(sum(nSize=82)))

y <- statsfunc(x)
z <- plotfunc(x)
a <- posthocfunc(x)

