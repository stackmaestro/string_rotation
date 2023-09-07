const { RotationDb } = require('../db')
const { stringRotator } = require('../utils/rot-converter')

/**
 * Get the rot string on the base of original string in db
 * 
 * @param {string} content original string 
 * @returns the db response after saving it into the db
 */
const getRotation = async (originalString) => {
  try {
    return await RotationDb.fetch(originalString)
  } catch(e) {
    throw new Error(e.message)
  }
}

/**
 * Save the original and rot string in db
 * 
 * @param {string} originalString original string
 * @param {string} rotString rot13 string
 * @returns the db response after saving it into the db
 */
const saveEncryption = async (originalString, rotString) => {
  try {
    const content = { originalString, rotString }
    return await RotationDb.save(content)
  } catch(e) {
    throw new Error(e.message)
  }
}

/**
 * Encrypting the plain text into rot13 cypher
 * 
 * @param {string} inputString the orignal input string
 * @returns the rot13 cipher in the form of a plain text
 */
const encrypt = (inputString) => {
  const cypher = stringRotator(inputString);
  return cypher;
}

module.exports = {
  getRotation,
  saveEncryption,
  encrypt
}