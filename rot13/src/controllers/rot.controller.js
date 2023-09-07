const { RotationService } = require('../services')

/**
 * 
 * @param req the request object from where payload is taken 
 * @param res response object
 * 
 * @payload
 *  {
      "stringRotation": {
        "originalString": "This is a test message"
      }
    }
 * 
 * @response
 *  {
    "stringRotation": {
      "originalString": "This is a test message",
      "rotString": "Guvf vf n grfg zrffntr"
    }
  }
  *
  * first check whether rotation of string is in db or not, 
  * if is then simply return the string in db or if not, 
  * then string is encrypted over rot13 algorithm
  * after this original and rot13 strings are saved in db
 */
const convert = async (req, res) => {
  const { stringRotation } = req.body;
  const originalString = stringRotation ? stringRotation.originalString : null;
  try {
    if (originalString && typeof originalString === 'string') {
      const encryption = await RotationService.getRotation(originalString);
      if (encryption && encryption.rotString) {
        return res.json(encryption);
      }
      const rotString = RotationService.encrypt(originalString);
      const response = await RotationService.saveEncryption(originalString, rotString);
      return res.json({ stringRotation: response });
    } else {
      res.status(400).json({error: true, status: 400, message: 'Bad request please check payload!'});
    }
  } catch(e) {
    res.status(500).json({error: true, status: 500, message: e.message});
  }
}

module.exports = {
  convert
}