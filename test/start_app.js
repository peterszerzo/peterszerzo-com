'use strict';

const expect = require('chai').expect;
const isFunction = require('lodash/isFunction');

const startApp = require('../src/start_app');

describe('startApp', function() {

  it('is a function', function() {
    expect(isFunction(startApp)).to.equal(true);
  });

});
