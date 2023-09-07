const mongoose = require('mongoose');

const Schema = mongoose.Schema;

// defined schema to store orignal text
const Rotations = new Schema({
  originalString: {
    type: String,
    unique: true,
    index: true,
    required: true
  },
  rotString: {
    type: String,
    required: true
  },
},
{
  _id: true,
  timestamps: false
});

module.exports = mongoose.model('rotations', Rotations );