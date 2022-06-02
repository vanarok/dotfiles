/* eslint-env node */
require('@rushstack/eslint-patch/modern-module-resolution');

module.exports = {
  root: true,
  parser: 'vue-eslint-parser',
  plugins: ['@typescript-eslint', 'eslint-comments',
    'jest',
    'promise',
    'unicorn',
  ],
  parserOptions: {
    tsconfigRootDir: __dirname,
    parser: '@typescript-eslint/parser',
    sourceType: 'module',
    ecmaVersion: 'esNext',
    project: [
      './tsconfig.json',
      './tsconfig.node.json',
      './service-worker/tsconfig.json',
      './automation/tsconfig.json',
      './control/tsconfig.json',
    ],
  },
  globals: {
    chrome: true,
    node: true,
    browser: true,
    jest: true,
  },
  extends: [
    'airbnb-base',
    'airbnb-typescript/base',
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
    'plugin:@typescript-eslint/recommended-requiring-type-checking',
    'plugin:eslint-comments/recommended',
    'plugin:jest/recommended',
    'plugin:promise/recommended',
    'plugin:unicorn/recommended',
    'plugin:vue/vue3-recommended',
    '@vue/eslint-config-typescript/recommended',
    'prettier',
  ],
  'rules': {
    'import/no-unresolved': 'off',
    'import/extensions': ['error', 'ignorePackages', { '': 'never' }],
  },
  settings: {
    ['import/parser']: { '@typescript-eslint/parser': ['.ts', '.tsx'] },
    [`import/resolver`]: {
      node: { extension: ['.ts'] },
    },
  },
};
