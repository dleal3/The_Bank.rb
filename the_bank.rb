require_relative 'bank_classes'

@customers = []

@accounts = []

#Start of a method
def welcome_screen
  @current_customer = ""
  puts "Welcome to Tech Talent Bank."
  puts "Please choose from the following:"
  puts "------------------------------"
  puts "1.  Customer Sign-In"
  puts "2.  New Customer Registration"
  choice = gets.chomp.to_i

  case choice
  when 1 then sign_in #Create a sign_in method
  when 2 then sign_up("", "") #Create a sign_up method
  end
end

#Start of a second method
def sign_in
  print "Whats your name? "
  name = gets.chomp
  print "Whats your location? "
  location = gets.chomp

  if @customers.empty?
    puts "No customer found with that information."
    sign_up(name, location)
  end
  customer_exists = false
  @customers.each do |customer|
    if name == customer.name && location == customer.location
      @current_customer = customer
      customer_exists = true
    end
  end
  if customer_exists
    account_menu
  else
    puts "No customer found with that information."
    puts "1. Try again?"
    puts "2. Sign up"
    choice = gets.chomp.to_i
    case choice
    when 1 then sign_in
    when 2 then sign_up("", "")
    end
  end
end

#Start of a third method
def sign_up(name, location)
  if name == "" && location == ""
    print "What's your name?"
    name = gets.chomp
    print "What's your location?"
    location = gets.chomp
  end
  @current_customer = Customer.new(name, location)
  @customers.push(@current_customer)
  puts "Registration Successful!"
  account_menu
end



# THIS IS GOING TO CREATE AN ACCOUNT MENU
def account_menu
  puts "Account Menu"
  puts "------------------------"
  puts "1. Create an Account"
  puts "2. Review an Account"
  puts "3. Sign Out"
  choice = gets.chomp.to_i
  case choice
  when 1 then create_account # We need to create this method
  when 2 then review_account # We need to create this method
  when 3
    puts "Thanks for banking with us."
    welcome_screen
  else
    puts "Invalid Selection"
    account_menu
  end
end

def create_account
  print "How much will your initial deposit be? $"
  amount = gets.chomp.to_f
  print "What type of account will you be opening?"
  acct_type = gets.chomp
  new_acct = Account.new(@current_customer, amount, (@accounts.length+1), acct_type)
  @accounts.push(new_acct)
  puts "Account successfully created!"
  account_menu
end

def review_account
  @current_account = ""
  print "Which account (type) do you want to review? "
  type = gets.chomp.downcase
  account_exists = false
  @accounts.each do |account|
    if @current_customer == account.customer && type == account.acct_type.downcase
      @current_account = account
      account_exists = true
    end
  end
  if account_exists
    current_account_actions #Create this method
  else
    puts "Try again."
    review_account
  end
end

def current_account_actions
  puts "Choose from the Following: "
  puts "-------------------------"
  puts "1. Balance Check"
  puts "2. Make a Deposit"
  puts "3. Make a Withdrawal"
  puts "4. Return to Account Menu"
  puts "5. Sign Out"
  choice = gets.chomp.to_i
  case choice
  when 1
    puts "Current balance is $#{'%0.2f'%(@current_account.balance)}"
    current_account_actions
  when 2
    @current_account.deposit
    current_account_actions
  when 3
    @current_account.withdrawal
    current_account_actions
  when 4 then review_account

  when 5 then welcome_screen
  else
    puts "Invalid selection."
    current_account_actions
  end
end
welcome_screen
