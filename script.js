import { check } from 'k6';

let randomNumber = Math.random();

export async function presetup() {
    let randomNumber = Math.random();
    let my_obj = {}
    my_obj['hello'] = randomNumber
    return my_obj
}

export async function main_test(browser, data) {
    console.log("data", data)
    console.log("randomNumber", randomNumber)
    const page = browser.newPage();
    try {
        await page.goto('https://test.k6.io/my_messages.php', { waitUntil: 'networkidle' });
        // sleep(10)

        page.locator('input[name="login"]').type('admin');
        page.locator('input[name="password"]').type('123');

        const submitButton = page.locator('input[type="submit"]');

        await Promise.all([page.waitForNavigation(), submitButton.click()]);
        check(page, {
            'header': p => p.locator('h2').textContent() == 'Welcome, admin!',
        });
        check(page, {
            'header2': p => p.locator('h2').textContent() == 'Welcome, amin!',
        });
        // page.close();

    } finally {
        page.close();
    }
}
