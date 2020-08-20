mat = read.table("input_Msi_sort_add.csv",
                 header = TRUE, stringsAsFactors = FALSE, sep = ",")

#mat_cat <- rbind(mat1,mat2)
#mat<-mat_cat

mat[is.na(mat)] = ""
rownames(mat) = mat[, 1]
mat = mat[, -1]

mat = t(as.matrix(mat))

col = c("missense_variant"="#008000",
        "stop_gained"="red",
        "frameshift_variant"="blue",
        "inframe_deletion"="orange",
        "splice_acceptor_variant"="#C51B7D",
        "splice_donor_variant"="#DE77AE",
        "splice_region_variant"="#FDE0EF",
        "intron_variant"="#BF812D",
        "coding_sequence_variant"="#543005",
        "large_fragment_deletion"="#4292C6",
        "inframe_insertion"="#FD8D3C",
        "protein_altering_variant"="#08519C",
        "prime3_UTR_variant"="#9ECAE1",
        "prime5_UTR_variant"="#e97f02",
        "stop_lost"="#A50F15",
        "start_lost"="#CB181D",
        "synonymous_variant"="#FEE08B",
        "large_fragment_insertion"="#FFFFBF"
)

h_size=1
w_size=2
###############################This alter_fun is complex and low
alter_fun = list(
  background = function(x, y, w, h) {
    grid.rect(x, y, w-unit(w_size, "pt"), h-unit(h_size, "pt"), 
              gp = gpar(fill = "#CCCCCC", col = NA))
  },
  # big blue
  prime3_UTR_variant = function(x, y, w, h) {
    grid.rect(x, y, w-unit(w_size, "pt"), h-unit(h_size, "pt"), 
              gp = gpar(fill = col["prime3_UTR_variant"], col = NA))
  },
  prime5_UTR_variant = function(x, y, w, h) {
    grid.rect(x, y, w-unit(w_size, "pt"), h-unit(h_size, "pt"), 
              gp = gpar(fill = col["prime5_UTR_variant"], col = NA))
  },
  # big red
  coding_sequence_variant = function(x, y, w, h) {
    grid.rect(x, y, w-unit(w_size, "pt"), h-unit(h_size, "pt"), 
              gp = gpar(fill = col["coding_sequence_variant"], col = NA))
  },
  frameshift_variant = function(x, y, w, h) {
    grid.rect(x, y, w-unit(w_size, "pt"), h-unit(h_size, "pt"), 
              gp = gpar(fill = col["frameshift_variant"], col = NA))
  },
  # small green
  inframe_deletion = function(x, y, w, h) {
    grid.rect(x, y, w-unit(w_size, "pt"), h-unit(h_size, "pt"), 
              gp = gpar(fill = col["inframe_deletion"], col = NA))
  },
  inframe_insertion = function(x, y, w, h) {
    grid.rect(x, y, w-unit(w_size, "pt"), h-unit(h_size, "pt"), 
              gp = gpar(fill = col["inframe_insertion"], col = NA))
  },
  intron_variant = function(x, y, w, h) {
    grid.rect(x, y, w-unit(w_size, "pt"), h-unit(h_size, "pt"), 
              gp = gpar(fill = col["intron_variant"], col = NA))
  },
  large_fragment_deletion = function(x, y, w, h) {
    grid.rect(x, y, w-unit(w_size, "pt"), h-unit(h_size, "pt"), 
              gp = gpar(fill = col["large_fragment_deletion"], col = NA))
  },
  missense_variant = function(x, y, w, h) {
    grid.rect(x, y, w-unit(w_size, "pt"), h-unit(h_size, "pt"), 
              gp = gpar(fill = col["missense_variant"], col = NA))
  },
  protein_altering_variant = function(x, y, w, h) {
    grid.rect(x, y, w-unit(w_size, "pt"), h-unit(h_size, "pt"), 
              gp = gpar(fill = col["protein_altering_variant"], col = NA))
  },
  splice_acceptor_variant = function(x, y, w, h) {
    grid.rect(x, y, w-unit(w_size, "pt"), h-unit(h_size, "pt"), 
              gp = gpar(fill = col["splice_acceptor_variant"], col = NA))
  },
  splice_donor_variant = function(x, y, w, h) {
    grid.rect(x, y, w-unit(w_size, "pt"), h-unit(h_size, "pt"), 
              gp = gpar(fill = col["splice_donor_variant"], col = NA))
  },
  splice_region_variant = function(x, y, w, h) {
    grid.rect(x, y, w-unit(w_size, "pt"), h-unit(h_size, "pt"), 
              gp = gpar(fill = col["splice_region_variant"], col = NA))
  },
  stop_gained = function(x, y, w, h) {
    grid.rect(x, y, w-unit(w_size, "pt"), h-unit(h_size, "pt"), 
              gp = gpar(fill = col["stop_gained"], col = NA))
  },
  synonymous_variant = function(x, y, w, h) {
    grid.rect(x, y, w-unit(w_size, "pt"), h-unit(h_size, "pt"), 
              gp = gpar(fill = col["synonymous_variant"], col = NA))
  },
  upstream_gene_variant = function(x, y, w, h) {
    grid.rect(x, y, w-unit(w_size, "pt"), h-unit(h_size, "pt"), 
              gp = gpar(fill = col["upstream_gene_variant"], col = NA))
  },
  stop_lost = function(x, y, w, h) {
    grid.rect(x, y, w-unit(w_size, "pt"), h-unit(h_size, "pt"), 
              gp = gpar(fill = col["stop_lost"], col = NA))
  },
  start_lost = function(x, y, w, h) {
    grid.rect(x, y, w-unit(w_size, "pt"), h-unit(h_size, "pt"), 
              gp = gpar(fill = col["start_lost"], col = NA))
  }
  
)
##########################################################
variant_list <-c("missense_variant",
                 "stop_gained",
                 "frameshift_variant",
                 "inframe_deletion",
                 "splice_acceptor_variant",
                 "splice_donor_variant",
                 "splice_region_variant",
                 "intron_variant",
                 "coding_sequence_variant",
                 "large_fragment_deletion",
                 "inframe_insertion",
                 "protein_altering_variant",
                 "prime3_UTR_variant",
                 "prime5_UTR_variant",
                 "stop_lost",
                 "start_lost",
                 "synonymous_variant",
                 "large_fragment_insertion")
#设定图例以及图例title的位置
heatmap_legend_param = list(title = "", at = variant_list, 
                            labels = variant_list,
                            nrow=3, title_position = "leftcenter")
#分组
group_label <- c(rep(c("Colorectal"),224),
                 rep(c("Lung"),59),  ##add blank
                 rep(c("Gastric"),46),
                 rep(c("Endometrial"),19),
                 rep(c("Pancreatic"),7),
                 rep(c("Breast"),7),
                 rep(c("Head"),4),
                 rep(c("Ovarian"),3),
                 rep(c("Hepatocellular"),3),
                 rep(c("Neuroendocrine"),2),
                 rep(c("Cholangiocarcinoma"),2),
                 rep(c("Cervical"),2),
                 rep(c("Bladder"),2),  #add blank
                 rep(c("Soft"),1),     #add blank
                 rep(c("Prostate"),1),
                 rep(c("Kidney"),1),
                 rep(c("Gallbladder"),1),
                 rep(c("Esophageal"),1)
)
mat_groub_label <- data.frame(colnames(mat),group_label)
#因子化设定顺序
mat_groub_label$group_label <-factor(mat_groub_label$group_label,levels = c("Colorectal",
                                                                            "Lung",
                                                                            "Gastric",
                                                                            "Endometrial",
                                                                            "Pancreatic",
                                                                            "Breast",
                                                                            "Head",
                                                                            "Ovarian",
                                                                            "Hepatocellular",
                                                                            "Neuroendocrine",
                                                                            "Cholangiocarcinoma",
                                                                            "Cervical",
                                                                            "Bladder",
                                                                            "Soft",
                                                                            "Prostate",
                                                                            "Kidney",
                                                                            "Gallbladder",
                                                                            "Esophageal"))
#设置分组底部颜色
ha = HeatmapAnnotation(Cancer = mat_groub_label$group_label,
                       col = list(Cancer = c("Colorectal"="red",
                                            "Lung"="orange",
                                            "Gastric"="#B2ABD2",
                                            "Endometrial"="green",
                                            "Pancreatic"="blue",
                                            "Breast"="#A6CEE3",
                                            "Head"="#1F78B4",
                                            "Ovarian"="#B2DF8A",
                                            "Hepatocellular"="#33A02C",
                                            "Neuroendocrine"="#FB9A99",
                                            "Cholangiocarcinoma"="#E31A1C",
                                            "Cervical"="#FDBF6F",
                                            "Bladder"="#FF7F00",
                                            "Soft"="#08519C",
                                            "Prostate"="#CAB2D6",
                                            "Kidney"="#6A3D9A",
                                            "Gallbladder"="#B15928",
                                            "Esophageal"="#542788")),
                       show_annotation_name = FALSE)
label.title = "Mutation"
column_title = "OncoPrint for Msi sample num"

alter_fun = function(x, y, w, h, v) {
  #设置background
  grid.rect(x, y, w-unit(0.5, "mm"), h-unit(0.5, "mm"), 
            gp = gpar(fill = "#CCCCCC", col = NA))

  #动态添加柱子的参数
  n = sum(v)  # how many alterations for current gene in current sample
  h = h-unit(2, "pt")*0.9
  w = w-unit(2, "pt")
  if(n) grid.rect(x, y - h*0.5 + 1:n/n*h, w*0.9, 1/n*h, 
                  gp = gpar(fill = col[names(which(v))], col = NA), just = "top")
}

p <- oncoPrint(mat,
               column_split = mat_groub_label$group_label,#依据label数量，添加gap
               column_gap= unit(2, "mm"), #设置gap间隔，单位为毫米，数值越大间隔越大
               alter_fun = alter_fun,
               col = col,
               row_title="Frquency of Variant /Genes",
               column_title = column_title, 
               heatmap_legend_param = heatmap_legend_param,
               bottom_annotation =ha
               )

draw(p,heatmap_legend_side = "bottom")

#添加bar 图上的标签，该函数只能在原图上叠加，类似图层
decorate_annotation("cbar", { # the column name has the name "cbar"
  grid.text("Mutations,\nn/Samples", x = unit(-6, "mm"), 
            rot = 90, just = "bottom",
            gp=gpar(col="black",fontsize=8,fontface="bold"))
})

decorate_annotation("rbar", { # the column name has the name "cbar"
  grid.text("Mutations,\nn/Genes",y = unit(18.5, "cm"),
            just = "bottom",
            gp=gpar(col="black"))
})
