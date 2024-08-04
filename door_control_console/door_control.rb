# frozen_string_literal: true

# The point of this program is to learn Ruby, Arrays, If statements, case statements and functions
# The goal is to eventually convert this to a stateful database script so it retains data and multiple users can use it
# Then we'll move to rails and add some fancy frontend with tailwind.

# Constants
DEFAULT_USERS = [
  { name: "jace", pin: "1234", role: "admin" },
  { name: "tom", pin: "5678", role: "user" },
].freeze

USER_GROUPS = %w[admin user].freeze

# Definitions - Helper Functions
def clear
  system("clear") || system("cls")
end

def press_key_to_continue
  puts "Press any key to continue"
  gets
end

class DoorControl
  attr_accessor :users # Allow us to force set the user's array after the program is created in case of an emergency

  def initialize
    @users = DEFAULT_USERS.dup
  end

  def user_exists?(username)
    @users.any? { |user| user[:name] == username.downcase }
  end

  def pin_valid?(username, pin)
    false unless user_exists?(username)
    @users.any? { |user| user[:name] == username.downcase && user[:pin] == pin }
  end

  def check_role?(username)
    user = @users.find { |user| user[:name] == username }
    user ? user[:role] : "user"
  end

  def user_admin?(username)
    role = check_role?(username)
    true if role == "admin"
  end

  def create_user(username, pin, role)
    @users.push({ name: username, pin:, role: })
  end

  def delete_user(username)
    # Use of a ternary operator
    @users.reject! { |user| user[:name] == username } ? true : false
  end

  def reset_pin(username, new_pin)
    user_to_reset = @users.find { |user| user[:name] == username }
    user_to_reset[:pin] = new_pin
  end

  def debug_get_all
    @users
  end
end

door_control = DoorControl.new

loop do
  print "What is your username?: "
  username = gets.chomp

  print "What is your PIN?: "
  pin = gets.chomp

  unless door_control.pin_valid?(username, pin)
    print "Sorry, that's an invalid username/key pair.\n\n"
    next
  end

  loop do
    clear

    puts "Welcome to the door control system",
         "You are logged in as #{username}\n\n",

         "What action would you like to take?",
         "1. Check your account's role",
         "2. Display the sign in screen again (Log Out)",
         "9. Exit\n\n"

    if door_control.user_admin?(username)
      puts "Admin only actions:",
           "3. Create new user",
           "4. Delete a user",
           "5. Reset a user's pin\n\n",

           "Debug actions (admin required):",
           "6. Show instance users\n\n"
    end

    print "Enter your action: "
    user_opt = gets.chomp.to_i

    case user_opt
      when 1
        user_role = door_control.check_role?(username)
        clear
        puts "Your user role is: #{user_role}."
        press_key_to_continue
      when 2
        clear
        puts "Logged you out. Please login again to continue using Door Control."
        break
      when 3
        next unless door_control.user_admin?(username)

        clear
        puts "Welcome to user creation. Please enter the details requested below."
        print "New username: "
        new_username = gets.chomp.downcase
        print "New PIN: "
        new_pin = gets.chomp
        new_group = ""
        loop do
          print "User group (admin/user): "
          new_group = gets.chomp.downcase
          break if USER_GROUPS.include?(new_group)

          puts "Invalid group. Please enter 'admin' or 'user'."
        end
        door_control.create_user(new_username, new_pin, new_group)
      when 4
        next unless door_control.user_admin?(username)

        user_delete = ""
        loop do
          clear
          print "Who are you deleting?: "
          user_delete = gets.chomp.downcase

          unless door_control.user_exists?(user_delete)
            puts "That's not a real user??"
            next
          end

          break
        end

        stop_go = ""
        loop do
          print "Are you sure you want to delete #{user_delete}? They will not be able to login! (Y/N): "
          stop_go = gets.chomp.downcase
          break if %w[y n].include?(stop_go)
        end

        clear
        if stop_go == "n"
          puts "You have cancelled clearing the user.\nPress any key to go back"
          gets
          next
        else
          success = door_control.delete_user(user_delete)
          puts "Deleted user #{user_delete}" unless !success
        end

      when 5
        next unless door_control.user_admin?(username)

        puts "Welcome to the PIN Reset Wizard"
        print "What user would you like to reset the PIN of: "
        new_user = gets.chomp.downcase
        puts "That user doesn't exit silly." unless door_control.user_exists?(new_user)
        new_pin = rand(1000..9999)
        door_control.reset_pin(new_user, new_pin)
        puts "Done Successfully. Press any key to continue"
        gets

      when 6
        puts "Debug Show users"
        puts door_control.debug_get_all
        gets
      else
        clear
        puts "That's an invalid action!"
        press_key_to_continue
    end
  end
end
