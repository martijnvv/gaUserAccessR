# Libraries and functions loaded ------------------------------------------
library(googleAnalyticsR)
#additional packages used: stringi, dplyr, writexl

# Authenticate API --------------------------------------------------------
ga_auth()

# Determine Account ID ----------------------------------------------------
account_id <- "XXXX" #update to match your GA settings
ua_code <- "UA-XXXXX-XX" #update to match your GA settings
view_id <- "XXXXXX" #update to match your GA settings

# Get User access data ----------------------------------------------------
c("gmail.com", "hotmail.com", "kpn.com", "kpnmail.com") -> non_company_mail  #non-company emails
  
ga_users_list(accountId = account_id, viewId = view_id, webPropertyId = ua_code) -> user_access

stringi::stri_detect_fixed(user_access$permissions.effective, "MANAGE_USERS") -> user_access$admin_access
stringi::stri_detect_regex(user_access$userRef.email, paste(non_company_mail, collapse='|')) -> user_access$no_company

gsub(".*@","",user_access$userRef.email) -> user_access$extension
  
user_access %>%
  dplyr::group_by(extension) %>%
  dplyr::summarise(count = n()) -> user_company_access

user_access[,c("entity.profileRef.name", "userRef.email","permissions.effective","admin_access", "extension", "no_company")] -> user_access_clean    
colnames(user_access_clean) <- c("view_name", "email", "access_level", "admin_access", "email_extension", "no_company_extension")

# Additional basic calculations -------------------------------------------
nrow(user_access) -> user_access_count # count users with access  
nrow(user_company_access) -> user_access_companies #number of companies
sum(user_access$admin_access, na.rm = TRUE) -> user_access_admin_count #user count with admin access
sum(user_access$no_company, na.rm = TRUE) -> user_access_nocompany_count #user count with admin access

# Create list for Export --------------------------------------------------
list(user_access_clean,user_company_access) -> list_new

# Write to Excel ----------------------------------------------------------
writexl::write_xlsx(list_new, paste0("data/output/user_access_",ua_code,".xlsx"))
