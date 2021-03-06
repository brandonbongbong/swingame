from pas_tokeniser import SGPasTokeniser
from pas_token_kind import TokenKind
from pas_token import Token

from pas_parser_utils import logger

class SGTokenStream(object):
    """A stream of tokens the parsing code can move through"""
    
    def __init__(self, filename):
        super(SGTokenStream, self).__init__()
        
        # Create the tokeniser
        self._tokeniser = SGPasTokeniser()
        self._tokeniser.tokenise(filename)
        self._current_file = filename
        
        # Keep track of the lookahead tokens
        self._lookahead_toks = []
    
    def next_token(self):
        current_token = None
        while current_token == None or current_token._kind == TokenKind.Comment:
            if len(self._lookahead_toks) > 0:
                current_token = self._lookahead_toks[0]
                self._lookahead_toks = self._lookahead_toks[1:]
            else:
                current_token = self._tokeniser.next_token()
            if current_token._kind == TokenKind.Comment:
                logger.debug('TokenStream   : Skipping comment: %s', current_token._value)
        return current_token
    
    def lookahead(self,count=1):
        """
        lookahead generates a list of Tokens that has count number of members
        It ignores comments
        """
        logger.debug('TokenStream    : Looking ahead %d', count)
        while len(self._lookahead_toks) < count:
            current_token = self._tokeniser.next_token()
            while current_token._kind == TokenKind.Comment:
                current_token = self._tokeniser.next_token()
            self._lookahead_toks.append(current_token)
        return self._lookahead_toks
    
    def match_lookahead(self, token_kind, token_value = None, consume = False):
        """
        looks forward one position for a token with a specific value and kind
        if the token is found it returns true and optionally consume the token. 
        Otherwise it returns false without consuming a token.
        """
        logger.debug('TokenStream   : Looking to find %s (%s)%s', token_kind, 
            token_value if token_value != None else 'any',
            ' will consume' if consume else '')
        token = self.lookahead(1)[0]
        result = token._kind == token_kind and (token_value == None or token_value == token._value.lower())
        if consume and result:
            self.match_token(token_kind, token_value)
        return result

    def match_token(self, token_kind, token_value = None):
        """
        Looks at the next token, and if it is the same kind as 'token_kind' and
        has the same value as 'token_value' then it is returned. Otherwise an 
        error occurs and the program stops.

        If 'token_value' is None then only the 'token_kind' is checked.
        """
        tok = self.next_token()
        
        if tok._kind != token_kind or (token_value != None and token_value != tok._value.lower()):
            logger.error('TokenStream        %s: found a %s (%s) expected %s (%s)', 
                self._tokeniser.line_details(), 
                tok._kind, tok._value, token_kind, token_value)
            assert False
            
        logger.debug('TokenStream    : Matched token %s (%s)', tok._kind, tok._value)
        return tok
    
    def match_one_lookahead(self, token_lst, consume = False):
        """
        Tries to match the next token's value with a list of values
        Returns True if a match is found, and false if there was no match
        """
        tok = self.lookahead()[0]

        logger.debug('TokenStream   : Looking to find %s %s', token_lst, 
            ' will consume' if consume else '')

        for token_kind,token_value in token_lst:
            if tok._kind == token_kind and (token_value == None or token_value == tok._value):
                matched = True
                logger.debug('TokenStream    : Found %s (%s)', tok._kind, tok._value)
                if consume:
                    self.match_token(tok._kind, tok._value)
                return True

        return False

    def match_one_token(self, token_lst):
        """
        Finds and returns the token match within a list of
        tokenIdentifier - value pairs.
        Will throw an error if no match could be found
        """
        matched = self.match_one_lookahead(token_lst, True)
        tok = self.next_token()
        if not matched:
            logger.error('TokenStream    %s: unexpected %s(%s) expected %s', 
                self._tokeniser.line_details(), 
                tok._kind, tok._value, 
                map(lambda n: '%s(%s)' % (n[0],n[1]),token_kind_lst))
            assert False
        return tok

        