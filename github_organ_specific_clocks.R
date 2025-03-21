# =============================================================================
# input file: UK Biobank olink proteomic data (id column followed by proteins)
# =============================================================================

pro <- fread("example_proteomic_data.txt")
setDF(pro)

# ===========================================================================================
# coefficients associated with proteins in first- and second-generation organ-specific clocks
# ===========================================================================================

clock1st_coef <- fread("first_generaltion_clocks_coef.csv") #first fold out in Table S1A of Goeminne et al.
setDF(clock1st_coef)
clock1st_coef$Model <- tolower(clock1st_coef$Model)
clock2nd_coef <- fread("second_generation_clocks_coef.csv") #first fold out in Table S1C of Goeminne et al.
setDF(clock2nd_coef)
clock2nd_coef$Model <- tolower(clock2nd_coef$Model)

# ==================================================================
# match protein names in pro and in clock1st_coef and clock2nd_coef
# ==================================================================

cat("missing proteins in first-generation organ-specific clocks:",clock1st_coef$Model[-1][which(!clock1st_coef$Model[-1]%in%names(pro))],"\n")
cat("proteins in the data, not in the clock1st_coeft?",names(pro)[-1][!names(pro)[-1]%in%clock1st_coef$Model],"\n")
cat("missing proteins in the second-genration organ-specific clocks:",clock2nd_coef$Model[which(!clock2nd_coef$Model%in%names(pro))],"\n")
cat("proteins in the data, not in the clock1st_coeft?",names(pro)[-1][!names(pro)[-1]%in%clock2nd_coef$Model],"\n")

# rename the missing proteins
clock1st_coef$Model[which(!clock1st_coef$Model%in%names(pro))] <- c("intercept","ervv.1","hla.a","hla.dra","hla.e") 
clock2nd_coef$Model[which(!clock2nd_coef$Model%in%names(pro))] <- c("ervv.1","hla.a","hla.dra","hla.e") 

# double check
table(clock1st_coef$Model[-1]%in%names(pro))
table(clock2nd_coef$Model%in%names(pro))

eid <- pro$eid
# first-generation organ specific clocks
pro_sorted <- pro[,clock1st_coef$Model[-1]]
intercept <- rep(1,nrow(pro_sorted))
pro_sorted <- data.frame(intercept,pro_sorted)
clock1st_coef <- clock1st_coef[,-1]
out1 <- as.matrix(pro_sorted)%*%as.matrix(clock1st_coef)
out1 <- data.frame(eid,out1)
out1 <- out1[order(out1$eid),]
write.table(out1,"first_generation_organ_specific_proteomic_clocks.txt",row.names=FALSE,col.names=TRUE,quote=FALSE,sep="\t")

# second-generation organ specific clocks
pro_sorted <- pro[,clock2nd_coef$Model]
clock2nd_coef <- clock2nd_coef[,-1]
out2 <- as.matrix(pro_sorted)%*%as.matrix(clock2nd_coef)
out2 <- data.frame(eid,out2)
out2 <- out2[order(out2$eid),]
write.table(out2,"second_generation_organ_specific_proteomic_clocks.txt",row.names=FALSE,col.names=TRUE,quote=FALSE,sep="\t")