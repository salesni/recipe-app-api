
from unittest.mock import patch

from django.core.management import call_command
from django.db.utils import OperationalError
from django.test import TestCase


class CommandTests(TestCase):

    def test_wait_for_db_ready(self):
        """Test waiting for db when db is available"""
        #We create the Mock object gi to make the tests witthout using the Database
        with patch('django.db.utils.ConnectionHandler.__getitem__') as gi:
            gi.return_value = True
            #To call a management command from code
            call_command('wait_for_db')
            #gi.call_count it returns the number of times that the function was called
            self.assertEqual(gi.call_count, 1)

    #Decorator of a function and it passes the value as  a parameter in the function  ts
    @patch('time.sleep', return_value=True)
    def test_wait_for_db(self, ts):
        """Test waiting for db"""
        with patch('django.db.utils.ConnectionHandler.__getitem__') as gi:
            #Side effect to the mocking function, it would raise the Error 5 times 
            gi.side_effect = [OperationalError] * 5 + [True]
            call_command('wait_for_db')
            self.assertEqual(gi.call_count, 6)