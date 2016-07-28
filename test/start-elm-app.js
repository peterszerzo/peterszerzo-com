'use strict';

const expect = require('chai').expect;
const isFunction = require('lodash/isFunction');

const startElmApp = require('../src/start-elm-app');

describe('startElmApp', function() {

  it('is a function', function() {
    expect(isFunction(startElmApp)).to.equal(true);
  });

});
