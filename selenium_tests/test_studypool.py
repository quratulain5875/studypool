"""
============================================================
Selenium Automated Tests - Studypool Clone
FA23-BCS-195
============================================================
Test Cases:
  1. Verify homepage (signin page) loads correctly
  2. Verify sign-in form validation (empty submission)
  3. Verify sign-in with invalid credentials
  4. Verify navigation from Sign In to Sign Up page
  5. Verify Sign Up form elements are present
============================================================
Prerequisites:
  - pip install selenium webdriver-manager
  - Application running at http://localhost:8081
  - Chrome browser installed
============================================================
"""

import time
import sys
import os
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from webdriver_manager.chrome import ChromeDriverManager

# ---- Configuration ----
BASE_URL = "http://20.247.53.92"
SIGNIN_URL = f"{BASE_URL}/signin.php"
SIGNUP_URL = f"{BASE_URL}/signup.php"


def create_driver():
    """Create and return a Chrome WebDriver instance."""
    chrome_options = Options()
    chrome_options.add_argument("--start-maximized")
    # Uncomment the line below for headless mode (no browser window)
    # chrome_options.add_argument("--headless")
    chrome_options.add_argument("--no-sandbox")
    chrome_options.add_argument("--disable-dev-shm-usage")

    service = Service(ChromeDriverManager().install())
    driver = webdriver.Chrome(service=service, options=chrome_options)
    driver.implicitly_wait(10)
    return driver


def print_result(test_name, passed, details=""):
    """Print formatted test result."""
    status = "[PASSED]" if passed else "[FAILED]"
    print(f"  {status} | {test_name}")
    if details:
        print(f"           └─ {details}")


# ============================================================
# TEST CASE 1: Verify Homepage Loads (Sign In Page)
# ============================================================
def test_homepage_loads(driver):
    """
    Test: Navigate to the base URL and verify that the sign-in
    page loads correctly with the expected title and form elements.
    """
    test_name = "TC-01: Homepage (Sign In page) loads correctly"
    try:
        driver.get(BASE_URL)
        time.sleep(2)

        # The index.php redirects to signin.php
        # Check that the page title contains "Sign In"
        assert "Sign In" in driver.title or "Study Pool" in driver.title, \
            f"Unexpected title: {driver.title}"

        # Verify the sign-in form is present
        email_field = driver.find_element(By.ID, "email")
        password_field = driver.find_element(By.ID, "password")
        submit_btn = driver.find_element(By.CSS_SELECTOR, "button.btn-primary")

        assert email_field.is_displayed(), "Email field not visible"
        assert password_field.is_displayed(), "Password field not visible"
        assert submit_btn.is_displayed(), "Submit button not visible"

        driver.save_screenshot("screenshots/tc_01_homepage_loaded.png")
        print_result(test_name, True, f"Page title: '{driver.title}'")
        return True

    except Exception as e:
        print_result(test_name, False, str(e))
        return False


# ============================================================
# TEST CASE 2: Sign In Form Validation (Empty Submission)
# ============================================================
def test_signin_empty_form(driver):
    """
    Test: Attempt to submit the sign-in form with empty fields.
    The HTML5 'required' attribute should prevent submission.
    """
    test_name = "TC-02: Sign In form validates empty fields"
    try:
        driver.get(SIGNIN_URL)
        time.sleep(2)

        # Clear fields to make sure they're empty
        email_field = driver.find_element(By.ID, "email")
        password_field = driver.find_element(By.ID, "password")
        email_field.clear()
        password_field.clear()

        # Try clicking submit
        submit_btn = driver.find_element(By.CSS_SELECTOR, "button.btn-primary")
        submit_btn.click()
        time.sleep(1)

        # If HTML5 validation works, we should still be on the same page
        # The email field should show a validation message
        is_valid = driver.execute_script(
            "return document.getElementById('email').validity.valid;"
        )

        assert not is_valid, "Form should not be valid with empty fields"

        driver.save_screenshot("screenshots/tc_02_empty_form_validation.png")
        print_result(test_name, True, "HTML5 validation prevented empty submission")
        return True

    except Exception as e:
        print_result(test_name, False, str(e))
        return False


# ============================================================
# TEST CASE 3: Sign In with Invalid Credentials
# ============================================================
def test_signin_invalid_credentials(driver):
    """
    Test: Enter invalid email/password and submit the form.
    The application should show an error alert.
    """
    test_name = "TC-03: Sign In rejects invalid credentials"
    try:
        driver.get(SIGNIN_URL)
        time.sleep(2)

        # Enter invalid credentials
        email_field = driver.find_element(By.ID, "email")
        password_field = driver.find_element(By.ID, "password")

        email_field.clear()
        email_field.send_keys("invalid_user@test.com")

        password_field.clear()
        password_field.send_keys("wrong_password_123")

        # Submit the form
        submit_btn = driver.find_element(By.CSS_SELECTOR, "button.btn-primary")
        submit_btn.click()
        time.sleep(2)

        # Try to handle the JavaScript alert if present
        try:
            alert = driver.switch_to.alert
            alert_text = alert.text
            alert.accept()
            print_result(test_name, True, f"Alert message: '{alert_text}'")
        except Exception:
            # No alert, but still on signin page = credentials rejected
            print_result(test_name, True, "Stayed on sign-in page (credentials rejected)")

        # Check if we're still on the signin page (not redirected to dashboard)
        current_url = driver.current_url
        driver.save_screenshot("screenshots/tc_03_invalid_credentials.png")
        assert "signin" in current_url or "sign" in current_url.lower(), \
            f"Should stay on sign in page, but redirected to: {current_url}"

        return True

    except Exception as e:
        print_result(test_name, False, str(e))
        return False


# ============================================================
# TEST CASE 4: Navigation from Sign In to Sign Up
# ============================================================
def test_navigation_to_signup(driver):
    """
    Test: Click the 'Sign up' link on the sign-in page and
    verify that the sign-up page loads correctly.
    """
    test_name = "TC-04: Navigation from Sign In → Sign Up works"
    try:
        driver.get(SIGNIN_URL)
        time.sleep(2)

        # Find and click the "Sign up" tab/link
        signup_link = driver.find_element(By.CSS_SELECTOR, "a[href='signup.php']")
        signup_link.click()
        time.sleep(2)

        # Verify we're on the signup page
        current_url = driver.current_url
        assert "signup" in current_url.lower(), \
            f"Expected signup page, got: {current_url}"

        # Verify Sign Up page title
        assert "Sign Up" in driver.title or "Study Pool" in driver.title, \
            f"Unexpected page title: {driver.title}"

        driver.save_screenshot("screenshots/tc_04_signup_page_loaded.png")
        print_result(test_name, True, f"Navigated to: {current_url}")
        return True

    except Exception as e:
        print_result(test_name, False, str(e))
        return False


# ============================================================
# TEST CASE 5: Sign Up Form Elements Present
# ============================================================
def test_signup_form_elements(driver):
    """
    Test: Navigate to the sign-up page and verify all required
    form fields are present (username, email, password, role).
    """
    test_name = "TC-05: Sign Up form has all required fields"
    try:
        driver.get(SIGNUP_URL)
        time.sleep(2)

        # Check for all required form fields
        username_field = driver.find_element(By.ID, "username")
        email_field = driver.find_element(By.ID, "email")
        password_field = driver.find_element(By.ID, "password")
        role_field = driver.find_element(By.ID, "role")
        submit_btn = driver.find_element(By.CSS_SELECTOR, "button.btn-primary")

        # Verify all fields are displayed
        assert username_field.is_displayed(), "Username field not visible"
        assert email_field.is_displayed(), "Email field not visible"
        assert password_field.is_displayed(), "Password field not visible"
        assert role_field.is_displayed(), "Role dropdown not visible"
        assert submit_btn.is_displayed(), "Submit button not visible"

        # Verify input types
        assert email_field.get_attribute("type") == "email", "Email field type mismatch"
        assert password_field.get_attribute("type") == "password", "Password field type mismatch"

        # Verify role dropdown has the correct options
        role_options = role_field.find_elements(By.TAG_NAME, "option")
        role_values = [opt.get_attribute("value") for opt in role_options]
        assert "student" in role_values, "Missing 'student' role option"
        assert "tutor" in role_values, "Missing 'tutor' role option"

        driver.save_screenshot("screenshots/tc_05_signup_elements_checked.png")
        print_result(test_name, True, f"Found {len(role_options)} role options: {role_values}")
        return True

    except Exception as e:
        print_result(test_name, False, str(e))
        return False


# ============================================================
# MAIN - Test Runner
# ============================================================
def main():
    print("=" * 60)
    print("  SELENIUM AUTOMATED TESTS - Studypool Clone")
    print("  FA23-BCS-195")
    print("=" * 60)
    print(f"  Target URL: {BASE_URL}")
    print(f"  Timestamp:  {time.strftime('%Y-%m-%d %H:%M:%S')}")
    print("=" * 60)
    print()

    driver = None
    results = []

    try:
        print("[*] Initializing Chrome WebDriver...")
        os.makedirs("screenshots", exist_ok=True)
        driver = create_driver()
        print("[*] WebDriver ready. Running tests...\n")

        # Run all test cases
        print("─" * 50)
        results.append(test_homepage_loads(driver))
        results.append(test_signin_empty_form(driver))
        results.append(test_signin_invalid_credentials(driver))
        results.append(test_navigation_to_signup(driver))
        results.append(test_signup_form_elements(driver))
        print("─" * 50)

    except Exception as e:
        print(f"\n[!] CRITICAL ERROR: {e}")
        results.append(False)

    finally:
        if driver:
            driver.quit()
            print("\n[*] WebDriver closed.")

    # Print summary
    passed = sum(results)
    total = len(results)
    print()
    print("=" * 60)
    print(f"  TEST RESULTS: {passed}/{total} passed")
    if passed == total:
        print("  STATUS: ALL TESTS PASSED [OK]")
    else:
        print(f"  STATUS: {total - passed} TEST(S) FAILED [ERROR]")
    print("=" * 60)

    # Exit with non-zero code if any test failed
    sys.exit(0 if passed == total else 1)


if __name__ == "__main__":
    main()
