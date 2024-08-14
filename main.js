import { browser } from 'k6/experimental/browser';
import { check } from 'k6';
import { htmlReport } from "https://raw.githubusercontent.com/benc-uk/k6-reporter/main/dist/bundle.js";
import { sleep } from 'k6';
import { main_test } from './script.js';
import { presetup } from './script.js';
import { textSummary } from "https://jslib.k6.io/k6-summary/0.0.1/index.js";

export const options = {
    scenarios: {
        ui: {
            executor: 'constant-vus',
            vus: 2,
            duration: '60s',
            options: {
                browser: {
                    type: 'chromium',
                },
            },
        },
    },
    thresholds: {
        checks: ['rate==1.0'],
    }
};

export function setup() {
    return presetup()
}

export default async function (data) {
    main_test(browser, data);
}

export function teardown(data) {
    // 4. teardown code
}

export function handleSummary(data) {
    return {
        'reports/summary.json': JSON.stringify(data),
        'reports/summary.html': htmlReport(data),
        stdout: textSummary(data, { indent: ' ', enableColors: true }),
    };
}
