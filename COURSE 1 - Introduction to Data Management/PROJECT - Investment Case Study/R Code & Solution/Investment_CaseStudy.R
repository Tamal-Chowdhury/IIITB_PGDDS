# dplyr
install.packages("dplyr")
library(dplyr)
install.packages("tidyr")
library(tidyr)

################# Checkpoint 1: Data Cleaning 1 ########################

# Load the companies data to companies data frame
companies <- read.delim("companies.txt", header = T, sep="\t", na.strings = c("", "NA"), stringsAsFactors = F)
companies$permalink <- tolower(companies$permalink)

# Load the rounds data to rounds2 data frame
rounds2 <- read.csv("rounds2.csv", header = T, na.strings = c("", "NA"), stringsAsFactors = FALSE)
rounds2$company_permalink <- tolower(rounds2$company_permalink)

# 1.unique companies present in rounds2
length(unique(rounds2$company_permalink))

# 2.unique companies present in companies
length(unique(companies$permalink))

# 3.unique key for each company in companies data frame
if(length(unique(companies$permalink)) == length(companies$permalink))
{
  print("In companies data frame, permalink column is the unique key for each company")
}

# 4.Any companies in rounds2 not present in companies?
if(identical(row.names(rounds2[!unique(rounds2$company_permalink) %in% companies$permalink, ]), character(0)))
{
  print("There are no companies in the rounds2 which are not present in companies")
}

#5. Merge companies and rounds2 data frame
master_frame <- merge(rounds2, companies, by.x = 'company_permalink', by.y = 'permalink')

#5. observations present in master_frame
nrow(master_frame)

###############Checkpoint 2: Funding Type Analysis ##############################

# 1-4 Average investment amount for funding types (venture, angel, seed, and private equity)
fund_type_invest <- filter(master_frame, funding_round_type == "venture" | funding_round_type == "angel" | funding_round_type == "seed" | funding_round_type == "private_equity") %>%
  group_by(funding_round_type) %>%
  summarise(fund_avg = mean(raised_amount_usd, na.rm = T))

fund_type_invest

#5. investment type for Average funding amount in 5 to 15 million USD range
filter(fund_type_invest, between(fund_avg,5000000,15000000))

#########################Checkpoint 3: Country Analysis#######################

# top nine countries which received highest total funding for venture type
top9 <- filter(master_frame, funding_round_type == "venture" & country_code != "") %>% 
  group_by(country_code) %>% 
  summarise(invest_total = sum(raised_amount_usd, na.rm = T)) %>%
  arrange(desc(invest_total)) %>% head(n=9)

top9

######################Checkpoint 4: Sector Analysis 1#########################

# Extract primary sector of each category list from the category_list column
master_frame <- separate(master_frame, category_list, c("primary_sector"), sep = "\\|", remove=FALSE)

# Convert to Lower case & remove white spaces from primary_sector
master_frame$primary_sector <- gsub(" ","",tolower(master_frame$primary_sector))

# Load the mapping data to map_sector data frame
map_sector <- read.csv("mapping.csv", header = T, stringsAsFactors = FALSE, na.strings = c("", "NA"), check.names=FALSE)

# convert zero(0) to na in catergory_list column
map_sector$category_list <- gsub("0","na",map_sector$category_list)

# convert any [.na] to [.0]
map_sector$category_list <- gsub("\\.na",".0",map_sector$category_list)

# Convert to Lower case & remove white spaces from category_list
map_sector$category_list <- gsub(" ","",tolower(map_sector$category_list))

# Gather main sector for each category
map_sector <- gather(map_sector, main_sector, category_val, `Automotive & Sports`:`Social, Finance, Analytics, Advertising`)
map_sector <- map_sector[!(map_sector$category_val == 0 | is.na(map_sector$category_list)), -3]

# Map primary sector of master_frame to one of the eight main sectors in map_sector
master_frame <- merge(master_frame, map_sector, by.x='primary_sector', by.y ='category_list',all.x = TRUE)

###################Checkpoint 5: Sector Analysis 2 ############################

#filter out na values to keep eight main sectors in master_frame
master_frame <- filter(master_frame,!is.na(main_sector))

# Data Frame for Country1(USA)  for venture funding type & investmement range 5-15 million USD
D1 <- filter(master_frame, funding_round_type == "venture" & country_code == "USA" & between(raised_amount_usd,5000000,15000000))

# sector-wise total count & total amount of investment 
D1_toal_invest <- D1 %>% group_by(main_sector) %>%
  summarize(total_invest_cnt = length(raised_amount_usd), total_invest_amt = sum(raised_amount_usd)) %>%
  arrange(desc(total_invest_cnt), desc(total_invest_amt))

# Merge total count & total amount of investment to D1
D1 <- merge(D1, D1_toal_invest, all.x = T)

# Data Frame for Country2(GBR)  for venture funding type & investmement range 5-15 million USD
D2 <- filter(master_frame, funding_round_type == "venture" & country_code == "GBR" & between(raised_amount_usd,5000000,15000000))

# sector-wise total count & total amount of investment 
D2_toal_invest <- D2 %>% group_by(main_sector) %>%
  summarize(total_invest_cnt = length(raised_amount_usd), total_invest_amt = sum(raised_amount_usd)) %>%
  arrange(desc(total_invest_cnt), desc(total_invest_amt))

# Merge total count & total amount of investment to D2
D2 <- merge(D2, D2_toal_invest, all.x = T)

# Data Frame for Country3(IND)  for venture funding type & investmement range 5-15 million USD
D3 <- filter(master_frame, funding_round_type == "venture" & country_code == "IND" & between(raised_amount_usd,5000000,15000000))

# sector-wise total count & total amount of investment 
D3_toal_invest <- D3 %>% group_by(main_sector) %>%
  summarize(total_invest_cnt = length(raised_amount_usd), total_invest_amt = sum(raised_amount_usd)) %>%
  arrange(desc(total_invest_cnt), desc(total_invest_amt))

# Merge total count & total amount of investment to D3
D3 <- merge(D3, D3_toal_invest, all.x = T)

# Sector-wise Investment Analysis
# 1.Total number of investments count for Country1(USA)
length(D1$raised_amount_usd)

# 1.Total number of investments count for Country2(GBR)
length(D2$raised_amount_usd)

# 1.Total number of investments count for Country3(IND)
length(D3$raised_amount_usd)

# 2.Total amount of investment (USD) for Country1(USA)
sum(D1$raised_amount_usd)

# 2.Total amount of investment (USD) for Country2(GBR)
sum(D2$raised_amount_usd)

# 2.Total amount of investment (USD) for Country3(IND)
sum(D3$raised_amount_usd)

# Top 3 sector based on count of investments for Country1(USA)
top3_D1_sector <- D1 %>% 
  group_by(main_sector) %>% 
  summarize(total_invest_cnt = length(raised_amount_usd)) %>%
  arrange(desc(total_invest_cnt)) %>% head(n=3)

# 3.Top sector
top3_D1_sector$main_sector[1]

# 4.Second-best sector
top3_D1_sector$main_sector[2]

#5.Third-best sector
top3_D1_sector$main_sector[3]

# Top 3 sector based on count of investments for Country2(GBR)
top3_D2_sector <- D2 %>% 
  group_by(main_sector) %>% 
  summarize(total_invest_cnt = length(raised_amount_usd)) %>%
  arrange(desc(total_invest_cnt)) %>% head(n=3)

# 3.Top sector
top3_D2_sector$main_sector[1]

# 4.Second-best sector
top3_D2_sector$main_sector[2]

#5.Third-best sector
top3_D2_sector$main_sector[3]

# Top 3 sector based on count of investments for Country3(IND)
top3_D3_sector <- D3 %>% 
  group_by(main_sector) %>% 
  summarize(total_invest_cnt = length(raised_amount_usd)) %>%
  arrange(desc(total_invest_cnt)) %>% head(n=3)

# 3.Top sector
top3_D3_sector$main_sector[1]

# 4.Second-best sector
top3_D3_sector$main_sector[2]

#5.Third-best sector
top3_D3_sector$main_sector[3]

# Number of investments in top 3 sectors for Country1(USA)
# 6. top sector
top3_D1_sector$total_invest_cnt[1]
# 7. second-best sector 
top3_D1_sector$total_invest_cnt[2]
# 8.third-best sector
top3_D1_sector$total_invest_cnt[3]

# Number of investments in top 3 sectors for Country2(GBR)
# 6. top sector
top3_D2_sector$total_invest_cnt[1]
# 7. second-best sector 
top3_D2_sector$total_invest_cnt[2]
# 8.third-best sector
top3_D2_sector$total_invest_cnt[3]

# Number of investments in top 3 sectors for Country3(IND)
# 6. top sector
top3_D3_sector$total_invest_cnt[1]
# 7. second-best sector 
top3_D3_sector$total_invest_cnt[2]
# 8.third-best sector
top3_D3_sector$total_invest_cnt[3]

# 9.The company which received highest investment for top sector count-wise for Country1(USA)
high_invest_comp1_D1 <- D1 %>% 
  filter(main_sector == top3_D1_sector$main_sector[1]) %>%
  group_by(name) %>%
  summarize(total_invest_amt = sum(raised_amount_usd)) %>%
  arrange(desc(total_invest_amt)) %>% head(n=1)

high_invest_comp1_D1$name

# 10.The company which received highest investment for second-best sector count-wise for Country1(USA)
high_invest_comp2_D1 <- D1 %>% 
  filter(main_sector == top3_D1_sector$main_sector[2]) %>%
  group_by(name) %>%
  summarize(total_invest_amt = sum(raised_amount_usd)) %>%
  arrange(desc(total_invest_amt)) %>% head(n=1)

high_invest_comp2_D1$name

# 9.The company which received highest investment for top sector count-wise for Country2(GBR)
high_invest_comp1_D2 <- D2 %>% 
  filter(main_sector == top3_D2_sector$main_sector[1]) %>%
  group_by(name) %>%
  summarize(total_invest_amt = sum(raised_amount_usd)) %>%
  arrange(desc(total_invest_amt)) %>% head(n=1)

high_invest_comp1_D2$name

# 10.The company which received highest investment for second-best sector count-wise for Country2(GBR)
high_invest_comp2_D2 <- D2 %>% 
  filter(main_sector == top3_D2_sector$main_sector[2]) %>%
  group_by(name) %>%
  summarize(total_invest_amt = sum(raised_amount_usd)) %>%
  arrange(desc(total_invest_amt)) %>% head(n=1)

high_invest_comp2_D2$name

# 9.The company which received highest investment for top sector count-wise for Country3(IND)
high_invest_comp1_D3 <- D3 %>% 
  filter(main_sector == top3_D3_sector$main_sector[1]) %>%
  group_by(name) %>%
  summarize(total_invest_amt = sum(raised_amount_usd)) %>%
  arrange(desc(total_invest_amt)) %>% head(n=1)

high_invest_comp1_D3$name

# 10.The company which received highest investment for second-best sector count-wise for Country3(IND)
high_invest_comp2_D3 <- D3 %>% 
  filter(main_sector == top3_D3_sector$main_sector[2]) %>%
  group_by(name) %>%
  summarize(total_invest_amt = sum(raised_amount_usd)) %>%
  arrange(desc(total_invest_amt)) %>% head(n=1)

high_invest_comp2_D3$name

