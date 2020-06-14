# Important Notes
# (?=.{6,}) #At least 6 characters long
# (?=.*\d) #Contain at least one number
# (?=.*[A-Z]) #Contain at least one uppercase letter
# (?=.*[a-z]) #Contain at least one lowercase letter
# (?=.*[[:^alnum:]]) #Contain at least one symbol

PASSWORD_REQUIREMENTS = /\A
  (?=.{6,})
  (?=.*\d)
  (?=.*[A-Z])
  (?=.*[a-z])
  (?=.*[[:^alnum:]])
/x

QUARTERS = [0..0, 1..3, 4..6, 7..9, 10..12]